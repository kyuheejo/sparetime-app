//
//  GoogleOAuth.h
//  GoogleOAuthDemo
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


#import <UIKit/UIKit.h>

@protocol GoogleOAuthDelegate
-(void)authorizationWasSuccessful;
-(void)accessTokenWasRevoked;
-(void)responseFromServiceWasReceived:(NSString *)responseJSONAsString andResponseJSONAsData:(NSData *)responseJSONAsData;
-(void)errorOccuredWithShortDescription:(NSString *)errorShortDescription andErrorDetails:(NSString *)errorDetails;
-(void)errorInResponseWithBody:(NSString *)errorMessage;
@end


typedef enum {
    httpMethod_GET,
    httpMethod_POST,
    httpMethod_DELETE,
    httpMethod_PUT
} HTTP_Method;


@interface GoogleOAuth : UIWebView <UIWebViewDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, strong) id<GoogleOAuthDelegate> gOAuthDelegate;

-(void)authorizeUserWithClienID:(NSString *)client_ID andClientSecret:(NSString *)client_Secret
                    andParentView:(UIView *)parent_View andScopes:(NSArray *)scopes;
-(void)revokeAccessToken;
-(void)callAPI:(NSString *)apiURL withHttpMethod:(HTTP_Method)httpMethod
                    postParameterNames:(NSArray *)params postParameterValues:(NSArray *)values;

@end
