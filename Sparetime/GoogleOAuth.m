//
//  GoogleOAuth.m
//  GoogleOAuthDemo
//
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Gabriel Theodoropoulos
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "GoogleOAuth.h"

#define authorizationTokenEndpoint  @"https://accounts.google.com/o/oauth2/auth"
#define accessTokenEndpoint         @"https://accounts.google.com/o/oauth2/token"


@interface GoogleOAuth()

// The client ID from the Google Developers Console.
@property (nonatomic, strong) NSString *clientID;
// The client secret value from the Google Developers Console.
@property (nonatomic, strong) NSString *clientSecret;
// The redirect URI after the authorization code gets fetched. For mobile applications it is a standard value.
@property (nonatomic, strong) NSString *redirectUri;
// The authorization code that will be exchanged with the access token.
@property (nonatomic, strong) NSString *authorizationCode;
// The refresh token.
@property (nonatomic, strong) NSString *refreshToken;
// An array for storing all the scopes we want authorization for.
@property (nonatomic, strong) NSMutableArray *scopes;

// A NSURLConnection object.
@property (nonatomic, strong) NSURLConnection *urlConnection;
// The mutable data object that is used for storing incoming data in each connection.
@property (nonatomic, strong) NSMutableData *receivedData;

// The file name of the access token information.
@property (nonatomic, strong) NSString *accessTokenInfoFile;
// The file name of the refresh token.
@property (nonatomic, strong) NSString *refreshTokenFile;
// A dictionary for keeping all the access token information together.
@property (nonatomic, strong) NSMutableDictionary *accessTokenInfoDictionary;

// A flag indicating whether an access token refresh is on the way or not.
@property (nonatomic) BOOL isRefreshing;

// The parent view where the webview will be shown on.
@property (nonatomic, strong) UIView *parentView;


#pragma mark - Declaration of private methods

-(void)showWebviewForUserLogin;
-(void)exchangeAuthorizationCodeForAccessToken;
-(void)refreshAccessToken;
-(NSString *)urlEncodeString:(NSString *)stringToURLEncode;
-(void)storeAccessTokenInfo;
-(void)loadAccessTokenInfo;
-(void)loadRefreshToken;
-(BOOL)checkIfAccessTokenInfoFileExists;
-(BOOL)checkIfRefreshTokenFileExists;
-(BOOL)checkIfShouldRefreshAccessToken;
-(void)makeRequest:(NSMutableURLRequest *)request;

@end



@implementation GoogleOAuth

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set the access token and the refresh token file paths.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDirectory = [paths objectAtIndex:0];
        _accessTokenInfoFile = [[NSString alloc] initWithFormat:@"%@/acctok", docDirectory];
        _refreshTokenFile = [[NSString alloc] initWithFormat:@"%@/reftok", docDirectory];
    
        // Set the redirect URI.
        // This is taken from the Google Developers Console.
        _redirectUri = @"urn:ietf:wg:oauth:2.0:oob";
        
        // Make any other required initializations.
        _receivedData = [[NSMutableData alloc] init];
        _urlConnection = [[NSURLConnection alloc] init];
        _refreshToken = nil;
        _isRefreshing = NO;
    }
    return self;
}



#pragma mark - Public methods implementation


-(void)authorizeUserWithClienID:(NSString *)client_ID
                andClientSecret:(NSString *)client_Secret
                  andParentView:(UIView *)parent_View
                      andScopes:(NSArray *)scopes{
    
    // Store into the local private properties all the parameter values.
    _clientID = [[NSString alloc] initWithString:client_ID];
    _clientSecret = [[NSString alloc] initWithString:client_Secret];
    _scopes = [[NSMutableArray alloc] initWithArray:scopes copyItems:YES];
    _parentView = parent_View;
    
    // Check if the access token info file exists or not.
    if ([self checkIfAccessTokenInfoFileExists]) {
        // In case it exists load the access token info and check if the access token is valid.
        [self loadAccessTokenInfo];
        if ([self checkIfShouldRefreshAccessToken]) {
            // If the access token is not valid then refresh it.
            [self refreshAccessToken];
        }
        else{
            // Otherwise tell the caller through the delegate class that the authorization is successful.
            [self.gOAuthDelegate authorizationWasSuccessful];
        }
        
    }
    else{
        // In case that the access token info file is not found then show the
        // webview to let user sign in and allow access to the app.
        [self showWebviewForUserLogin];
    }
}


-(void)revokeAccessToken{
    // Set the revoke URL string.
    NSString *revokeURLString = [NSString stringWithFormat:@"https://accounts.google.com/o/oauth2/revoke?token=%@",
                                 [_accessTokenInfoDictionary objectForKey:@"access_token"]
                                 ];
    // Create and make a request based on the URL string.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:revokeURLString]];
    [self makeRequest:request];
    
    // Now that the request for revoking the access in Google has been made,
    // all local files regarding the access token should be removed as well.
    NSError *error = nil;
    // If the access token info file exists then delete it.
    if ([self checkIfAccessTokenInfoFileExists]) {
        [[NSFileManager defaultManager] removeItemAtPath:_accessTokenInfoFile error:&error];
        
        if (error != nil) {
            // If an error occurs while removing the access token info file then notify the caller class through the
            // next delegate method.
            [self.gOAuthDelegate errorOccuredWithShortDescription:@"Unable to delete access token info file."
                                                  andErrorDetails:[error localizedDescription]];
        }
    }
    
    // Check now if the refresh token file exists and then remove it.
    if ([self checkIfRefreshTokenFileExists]) {
        [[NSFileManager defaultManager] removeItemAtPath:_refreshTokenFile error:&error];
        
        if (error != nil) {
            // In case of an error while removing the file then notify the caller class through the delegate method.
            [self.gOAuthDelegate errorOccuredWithShortDescription:@"Unable to delete refresh token info file."
                                                  andErrorDetails:[error localizedDescription]];
        }
    }
    
    
    if (error == nil) {
        // If no error occured during file removals then use the next delegate method
        // to notify the caller class that the access has been revoked.
        [self.gOAuthDelegate accessTokenWasRevoked];
    }
}


-(void)callAPI:(NSString *)apiURL withHttpMethod:(HTTP_Method)httpMethod
                            postParameterNames:(NSArray *)params
                            postParameterValues:(NSArray *)values{
    
    // Check if the httpMethod value is valid.
    // If not then notify for error.
    if (httpMethod != httpMethod_GET && httpMethod != httpMethod_POST && httpMethod != httpMethod_DELETE && httpMethod != httpMethod_PUT) {
        [self.gOAuthDelegate errorOccuredWithShortDescription:@"Invalid HTTP Method in API call" andErrorDetails:@""];
    }
    else{
        // Create a string containing the API URL along with the access token.
        NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", apiURL, [_accessTokenInfoDictionary objectForKey:@"access_token"]];
        // Create a mutable request.
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        
        // Depending on the httpMethod value set the respective property of the request object.
        switch (httpMethod) {
            case httpMethod_GET:
                [request setHTTPMethod:@"GET"];
                break;
            case httpMethod_POST:
                [request setHTTPMethod:@"POST"];
                break;
            case httpMethod_DELETE:
                [request setHTTPMethod:@"DELETE"];
                break;
            case httpMethod_PUT:
                [request setHTTPMethod:@"PUT"];
                break;
                
            default:
                break;
        }
        
        
        // In case of POST httpMethod value, set the parameters and any other necessary properties.        
        if (httpMethod == httpMethod_POST) {
            // A string with the POST parameters should be built.
            // Create an empty string.
            NSString *postParams = @"";
            // Iterrate through all parameters and append every POST parameter to the postParams string.
            for (int i=0; i<[params count]; i++) {
                postParams = [postParams stringByAppendingString:[NSString stringWithFormat:@"%@=%@",
                                                                  [params objectAtIndex:i], [values objectAtIndex:i]]];
                
                // If the current parameter is not the last one then add the "&" symbol to separate post parameters.
                if (i < [params count] - 1) {
                    postParams = [postParams stringByAppendingString:@"&"];
                }
            }
            
            // Set any other necessary options.
            [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        }
        
        
        // Make the request.
        [self makeRequest:request];
    }
}


#pragma mark - Private methods implementation

-(void)showWebviewForUserLogin{
    // Create a string to concatenate all scopes existing in the _scopes array.
    NSString *scope = @"";
    for (int i=0; i<[_scopes count]; i++) {
        scope = [scope stringByAppendingString:[self urlEncodeString:[_scopes objectAtIndex:i]]];
        
        // If the current scope is other than the last one, then add the "+" sign to the string to separate the scopes.
        if (i < [_scopes count] - 1) {
            scope = [scope stringByAppendingString:@"+"];
        }
    }
    
    // Form the URL string.
    NSString *targetURLString = [NSString stringWithFormat:@"%@?scope=%@&redirect_uri=%@&client_id=%@&response_type=code",
                                 authorizationTokenEndpoint,
                                 scope,
                                 _redirectUri,
                                 _clientID];
    
    
    // Do some basic webview setup.
    [self setDelegate:self];
    [self setScalesPageToFit:YES];
    [self setAutoresizingMask:_parentView.autoresizingMask];
    
    // Make the request and add self (webview) to the parent view.
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:targetURLString]]];
    [_parentView addSubview:self];
}


-(void)exchangeAuthorizationCodeForAccessToken{
    // Create a string containing all the post parameters required to exchange the authorization code
    // with the access token.
    NSString *postParams = [NSString stringWithFormat:@"code=%@&client_id=%@&client_secret=%@&redirect_uri=%@&grant_type=authorization_code",
                            _authorizationCode,
                            _clientID,
                            _clientSecret,
                            _redirectUri];
    
    // Create a mutable request object and set its properties.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:accessTokenEndpoint]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Make the request.
    [self makeRequest:request];
}


-(void)refreshAccessToken{
    // Load the refrest token if it's not loaded alredy.
    if (_refreshToken == nil) {
        [self loadRefreshToken];
    }
    
    // Set the HTTP POST parameters required for refreshing the access token.
    NSString *refreshPostParams = [NSString stringWithFormat:@"refresh_token=%@&client_id=%@&client_secret=%@&grant_type=refresh_token",
                                   _refreshToken,
                                   _clientID,
                                   _clientSecret
                                   ];
    
    // Indicate that an access token refresh process is on the way.
    _isRefreshing = YES;
    
    // Create the request object and set its properties.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:accessTokenEndpoint]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[refreshPostParams dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Make the request.
    [self makeRequest:request];
}



-(NSString *)urlEncodeString:(NSString *)stringToURLEncode{
    // URL-encode the parameter string and return it.
    CFStringRef encodedURL = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                     (CFStringRef) stringToURLEncode,
                                                                     NULL,
                                                                     (CFStringRef)@"!@#$%&*'();:=+,/?[]",
                                                                     kCFStringEncodingUTF8);
    return (NSString *)CFBridgingRelease(encodedURL);
}


-(void)storeAccessTokenInfo{
    NSError *error;
    
    // Keep the access token info into a dictionary.
    _accessTokenInfoDictionary = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingMutableContainers error:&error];
    
    // Check if any error occured while converting NSData data to NSDictionary.
    if (error) {
        [self.gOAuthDelegate errorOccuredWithShortDescription:@"An error occured while saving access token info into a NSDictionary."
                                                andErrorDetails:[error localizedDescription]];
    }
    
    // Save the dictionary to a file.
    [_accessTokenInfoDictionary writeToFile:_accessTokenInfoFile atomically:YES];

    
    // If a refresh token is found inside the access token info dictionary then save it separately.
    if ([_accessTokenInfoDictionary objectForKey:@"refresh_token"] != nil) {
        // Extract the refresh token.
        _refreshToken = [[NSString alloc] initWithString:[_accessTokenInfoDictionary objectForKey:@"refresh_token"]];
        
        // Save the refresh token as data.
        [_refreshToken writeToFile:_refreshTokenFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        // If an error occurs while saving the refresh token notify the caller class.
        if (error) {
            [self.gOAuthDelegate errorOccuredWithShortDescription:@"An error occured while saving the refresh token."
                                                  andErrorDetails:[error localizedDescription]];
        }
    }
}


-(void)loadAccessTokenInfo{
    // Check if the access token info file exists.
    if ([self checkIfAccessTokenInfoFileExists]) {
        // Load the access token info from the file into the dictionary.
        _accessTokenInfoDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:_accessTokenInfoFile];
    }
    else{
        // If the access token info file doesn't exist then inform the caller class through the delegate.
        [self.gOAuthDelegate errorOccuredWithShortDescription:@"Access token info file was not found."
                                              andErrorDetails:@""];
    }
}


-(void)loadRefreshToken{
    // Check if the refresh token file exists.
    if ([self checkIfRefreshTokenFileExists]) {
        NSError *error;
        _refreshToken = [[NSString alloc] initWithContentsOfFile:_refreshTokenFile encoding:NSUTF8StringEncoding error:&error];
        
        // If an error occurs while saving the refresh token notify the caller class.
        if (error) {
            [self.gOAuthDelegate errorOccuredWithShortDescription:@"An error occured while loading the refresh token."
                                                  andErrorDetails:[error localizedDescription]];
        }
    }
}


-(BOOL)checkIfAccessTokenInfoFileExists{
    // If the access token info file exists return YES, otherwise return NO.
    return (![[NSFileManager defaultManager] fileExistsAtPath:_accessTokenInfoFile]) ? NO : YES;
}


-(BOOL)checkIfRefreshTokenFileExists{
    // If the refresh token file exists then return YES, otherwise return NO.
    return (![[NSFileManager defaultManager] fileExistsAtPath:_refreshTokenFile]) ? NO : YES;
}


-(BOOL)checkIfShouldRefreshAccessToken{
    NSError *error = nil;

    // Get the time-to-live (in seconds) value regarding the access token.
    int accessTokenTTL = [[_accessTokenInfoDictionary objectForKey:@"expires_in"] intValue];
    // Get the date that the access token file was created.
    NSDate *accessTokenInfoFileCreated = [[[NSFileManager defaultManager] attributesOfItemAtPath:_accessTokenInfoFile error:&error]
                                          fileCreationDate];
    
    // Check if any error occured.
    if (error != nil) {
        [self.gOAuthDelegate errorOccuredWithShortDescription:@"Cannot read access token file's creation date."
                                              andErrorDetails:[error localizedDescription]];
        
        return YES;
    }
    else{
        // Get the time difference between the file creation date and now.
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:accessTokenInfoFileCreated];

        // Check if the interval value is equal or greater than the accessTokenTTL value.
        // If that's the case then the access token should be refreshed.
        if (interval >= accessTokenTTL) {
            // In this case the access token should be refreshed.
            return YES;
        }
        else{
            // Otherwise the access token is valid.
            return NO;
        }
    }
}


-(void)makeRequest:(NSMutableURLRequest *)request{
    // Set the length of the _receivedData mutableData object to zero.
    [_receivedData setLength:0];
    
    // Make the request.
    _urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}


#pragma mark - UIWebView Delegate methods

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    // Get the webpage title.
    NSString *webviewTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    // Check for the "Success token" literal in title.
    if ([webviewTitle rangeOfString:@"Success code"].location != NSNotFound) {
        // The oauth code has been retrieved.
        // Break the title based on the equal sign (=).
        NSArray *titleParts = [webviewTitle componentsSeparatedByString:@"="];
        // The second part is the oauth token.
        _authorizationCode = [[NSString alloc] initWithString:[titleParts objectAtIndex:1]];
        
        // Show a "Please wait..." message to the webview.
        NSString *html = @"<html><head><title>Please wait</title></head><body><h1>Please wait...</h1></body></html>";
        [self loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        
        // Exchange the authorization code for an access code.
        [self exchangeAuthorizationCodeForAccessToken];
    }
    else{
        if ([webviewTitle rangeOfString:@"access_denied"].location != NSNotFound) {
            // In case that the user tapped on the Cancel button instead of the Accept, then just
            // remove the webview from the superview.
            [webView removeFromSuperview];
        }
    }
}




#pragma mark - NSURLConnection Delegate methods

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    // Append any new data to the _receivedData object.
    [_receivedData appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    // This object will be used to store the converted received JSON data to string.
    NSString *responseJSON;
    
    // This flag indicates whether the response was received after an API call and out of the
    // following cases.
    BOOL isAPIResponse = YES;
    
    // Convert the received data in NSString format.
    responseJSON = [[NSString alloc] initWithData:(NSData *)_receivedData encoding:NSUTF8StringEncoding];
    
    // Uncomment this to log the JSON response.
    //NSLog(@"response JSON: %@", responseJSON);
    
    
    
    // Case 1. Check if an Invalid Request response was received.
    if ([responseJSON rangeOfString:@"invalid_request"].location != NSNotFound) {
        // If a refresh was on the way then set the respective flag to NO.
        if (_isRefreshing) {
            _isRefreshing = NO;
        }
        
        // Notify the caller class through the delegate.
        [self.gOAuthDelegate errorInResponseWithBody:responseJSON];
        
        
        isAPIResponse = NO;
    }
    
    
    // Case 2. Check for invalid refresh token.
    // In that case guide the user to enter the credentials again.
    if ([responseJSON rangeOfString:@"invalid_grant"].location != NSNotFound) {
        if (_isRefreshing) {
            _isRefreshing = NO;
        }
        
        [self showWebviewForUserLogin];
        
        isAPIResponse = NO;
    }
    
    
    // Case 3. Check for access token.
    if ([responseJSON rangeOfString:@"access_token"].location != NSNotFound) {
        // This is the case where the access token has been fetched.
        [self storeAccessTokenInfo];
        
        // Remove the webview from the superview.
        [self removeFromSuperview];
        
        if (_isRefreshing) {
            _isRefreshing = NO;
        }
        
        // Notify the caller class that the authorization was successful.
        [self.gOAuthDelegate authorizationWasSuccessful];
        
        isAPIResponse = NO;
    }
    
    
    // Case 4. Check for invalid credentials.
    // This checking is useful when an API is called without prior checking whether the
    // access token is valid or not.
    if ([responseJSON rangeOfString:@"Invalid Credentials"].location != NSNotFound ||
        [responseJSON rangeOfString:@"401"].location != NSNotFound) {
        
        // The access token is invalid.
        [self refreshAccessToken];
        
        isAPIResponse = NO;
    }
    
    
    // Case 5. This is the case where any other error message exists in the response.
    if ([responseJSON rangeOfString:@"error"].location != NSNotFound) {
        [self.gOAuthDelegate errorInResponseWithBody:responseJSON];
        isAPIResponse = NO;
    }
    
    
    // If execution successfully arrives here then notify the caller class that a response was received.
    if (isAPIResponse) {
        [self.gOAuthDelegate responseFromServiceWasReceived:responseJSON andResponseJSONAsData:_receivedData];
    }
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{    
    // Just let the caller class know through this delegate method.
    [self.gOAuthDelegate errorOccuredWithShortDescription:@"Connection failed." andErrorDetails:[error localizedDescription]];
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    //NSLog(@"%d", [httpResponse statusCode]);
}

@end
