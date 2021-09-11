//
//  googleViewController.m
//  Sparetime
//
//  Created by Brian Fisher on 3/12/19.
//  Copyright © 2019 Fisher Apps. All rights reserved.
//

#import "googleViewController.h"
#import "eventObject.h"
#import "syncViewController.h"

@interface googleViewController ()
@property (nonatomic, strong) GoogleOAuth *googleOAuth;
@property (nonatomic, strong) NSDictionary *dictCurrentCalendar;
// This array is one of the most important properties, as it contains
// all the calendars as NSDictionary objects.
@property (nonatomic, strong) NSMutableArray *arrGoogleCalendars;


@end

@implementation googleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    importButton.layer.cornerRadius = 10;
    importButton.clipsToBounds = YES;
           // navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

    NSString *importedGoogleCheck = [[NSUserDefaults standardUserDefaults]
        stringForKey:@"importedFromGoogle"];
    if (importedGoogleCheck) {
        [self performSegueWithIdentifier:@"alreadySyncedGoogle" sender:self];
    }
    _googleOAuth = [[GoogleOAuth alloc] initWithFrame:self.view.frame];
    // Set self as the delegate.
    [_googleOAuth setGOAuthDelegate:self];
       [_googleOAuth authorizeUserWithClienID:@"1076835361856-n0pkth3gamu8gdou63oohc1ajlnbdeqo.apps.googleusercontent.com"
                                   andClientSecret:@""
                                     andParentView:self.view
                                         andScopes:[NSArray arrayWithObject:@"https://www.googleapis.com/auth/calendar"]];


 
    // Do any additional setup after loading the view.
}

- (IBAction)post:(id)sender {
    // Before posting the event, check if the event description is empty or a date has not been selected.
    NSString *importedGoogleCheck = [[NSUserDefaults standardUserDefaults]
        stringForKey:@"importedFromGoogle"];
    NSString *calfieldtxt = calsField.text;

    if (importedGoogleCheck.length > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Already Imported!" message:@"You have already imported a google calendar and it will now sync all future events to Sparetime!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

        alert.bounds = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);
        [alert show];
    }
    else if ([calfieldtxt isEqualToString:@"Choose Calendar From List"]) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select Calendar!" message:@"Please select a calendar to import from" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

        alert.bounds = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);
        [alert show];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            _loadingView = [[UIView alloc] initWithFrame:CGRectMake(143, 228, 90, 90)];
            _loadingView.center = CGPointMake(self.view.frame.size.width  / 2,
                                     self.view.frame.size.height / 2);
            _loadingView.backgroundColor = [UIColor colorWithWhite:0. alpha:1.0];
            _loadingView.layer.cornerRadius = 5;
            
            ac=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            ac.center = CGPointMake(_loadingView.frame.size.width / 2.0, 35);
            [ac startAnimating];
            ac.tag = 100;
            [_loadingView addSubview:ac];
            
            lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 58, 80, 30)];
            lblLoading.text = @"Syncing...";
            lblLoading.textColor = [UIColor whiteColor];
            lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
            lblLoading.textAlignment = NSTextAlignmentCenter;
            [_loadingView addSubview:lblLoading];
            
            [self.view addSubview:_loadingView];
            [self.view bringSubviewToFront:_loadingView];

        });
    NSLog(@"post");
    int index = 0;
    NSString *txt = calsField.text;
    if (![txt isEqualToString:@"Choose Calendar From List"]) {
        for (int i = 0; i < calNamesArr.count; i++) {
            if ([calNamesArr[i] isEqualToString:txt]) {
                index = i;
                break;
            }
        }
        _dictCurrentCalendar = nil;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:index] forKey:@"calendarIndex"];

        [[NSUserDefaults standardUserDefaults] synchronize];
                        _dictCurrentCalendar = [[NSDictionary alloc] initWithDictionary:[_arrGoogleCalendars objectAtIndex:index]];
                       // NSLog(@"arrg %@",_arrGoogleCalendars);
                       // NSLog(@"dict %@",_dictCurrentCalendar);
            NSString *apiURLString = [NSString stringWithFormat:@"https://www.googleapis.com/calendar/v3/calendars/%@/events",
                                      [_dictCurrentCalendar objectForKey:@"id"]];
                [_googleOAuth callAPI:apiURLString
                   withHttpMethod:httpMethod_GET
               postParameterNames:nil
              postParameterValues:nil];
    }
    else {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Calendar Entered" message:@"Please choose a calendar to import!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

            alert.bounds = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);
            [alert show];


    }
}
}
- (IBAction)revokeAccess:(id)sender {
    // Revoke the access token.
    [_googleOAuth revokeAccessToken];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - GoogleOAuth class delegate method implementation

-(void)authorizationWasSuccessful{
    // If user authorization is successful, then make an API call to get the calendar list.
    // For more infomation about this API call, visit:
    // https://developers.google.com/google-apps/calendar/v3/reference/calendarList/list
    [_googleOAuth callAPI:@"https://www.googleapis.com/calendar/v3/users/me/calendarList"
           withHttpMethod:httpMethod_GET
       postParameterNames:nil
      postParameterValues:nil];
}
-(NSDate *)convertStringToDate:(NSString *) date {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSDate *nowDate = [[NSDate alloc] init];
        [formatter setDateFormat:@"YYYY-MM-DD'T'HH:mm:ssZ"];// set format here which format in string date
        /// also try this format @"yyyy-MM-dd'T'HH:mm:ss.fffK" 
        date = [date stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
        nowDate = [formatter dateFromString:date];
        // NSLog(@"date============================>>>>>>>>>>>>>>> : %@", nowDate);
        return nowDate;
}

-(void)responseFromServiceWasReceived:(NSString *)responseJSONAsString andResponseJSONAsData:(NSData *)responseJSONAsData{
    NSError *error;
    
    if ([responseJSONAsString rangeOfString:@"calendarList"].location != NSNotFound) {
        // If the response from Google contains the "calendarList" literal, then the calendar list
        // has been downloaded.
        
        // Get the JSON data as a dictionary.
        NSDictionary *calendarInfoDict = [NSJSONSerialization JSONObjectWithData:responseJSONAsData options:NSJSONReadingMutableContainers error:&error];
       // NSLog(@"%@",calendarInfoDict);
        
        if (error) {
            // This is the case that an error occured during converting JSON data to dictionary.
            // Simply log the error description.
            NSLog(@"%@", [error localizedDescription]);
        }
        else{
            // Get the calendars info as an array.
            NSArray *calendarsInfo = [calendarInfoDict objectForKey:@"items"];
            
            // If the arrGoogleCalendars array is nil then initialize it so to store each calendar as a NSDictionary object.
            if (_arrGoogleCalendars == nil) {
                _arrGoogleCalendars = [[NSMutableArray alloc] init];
            }
            
            // Make a loop and get the next data of each calendar.
            for (int i=0; i<[calendarsInfo count]; i++) {
                // Store each calendar in a temporary dictionary.
                NSDictionary *currentCalDict = [calendarsInfo objectAtIndex:i];
                                
                
                // Create an array which contains only the desired data.
                NSArray *values = [NSArray arrayWithObjects:[currentCalDict objectForKey:@"id"],
                                   [currentCalDict objectForKey:@"summary"],
                                   nil];
                // Create an array with keys regarding the values on the previous array.
                NSArray *keys = [NSArray arrayWithObjects:@"id", @"summary", nil];
                
                // Add key-value pairs in a dictionary and then add this dictionary into the arrGoogleCalendars array.
                [_arrGoogleCalendars addObject:
                 [[NSMutableDictionary alloc] initWithObjects:values forKeys:keys]];
                 NSLog(@"joseph");
        
            }
            calNamesArr = [[NSMutableArray alloc]init];

            for (int i = 0; i < _arrGoogleCalendars.count; i++) {
                NSDictionary *tempDict = [_arrGoogleCalendars objectAtIndex:i];
                [calNamesArr addObject:[tempDict objectForKey:@"summary"]];
            }
//NSLog(@"asdf%@",_arrGoogleCalendars);
//NSLog(@"%@",calNamesArr);
            self.downPicker = [[DownPicker alloc] initWithTextField:calsField withData:calNamesArr];
            // Set the first calendar as the selected one.
            _dictCurrentCalendar = [[NSDictionary alloc] initWithDictionary:[_arrGoogleCalendars objectAtIndex:0]];
            
            // Enable the post and the sign out bar button items.
    
        }
       // NSLog(@"%@",_arrGoogleCalendars);
      //          NSLog(@"%@",_dictCurrentCalendar);

        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
        NSString *minString =[dateFormatter stringFromDate:date];
        NSDate *endDate = [NSDate distantFuture];
        NSString *maxString =[dateFormatter stringFromDate:endDate];

        

    }
    else {
        // If the Google response contains the "calendar#event" literal then the event has been added to the selected calendar
        // and Google returns data related to the new event.
        
        // Get the response JSON as a dictionary.
        //NSLog(@"dogg");
        NSDate *nowDate = [NSDate date];

        NSDictionary *eventInfoDict = [NSJSONSerialization JSONObjectWithData:responseJSONAsData options:NSJSONReadingMutableContainers error:&error];
        NSString *str1 = [NSString stringWithFormat:@"my dictionary is %@", eventInfoDict];
//NSLog(@"@%@",str1);
          //NSLog(@"yosef%@", eventInfoDict);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 8 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
NSMutableArray *titleArr = [[NSMutableArray alloc]init];
NSMutableArray *startArr = [[NSMutableArray alloc]init];
NSMutableArray *endArr = [[NSMutableArray alloc]init];
NSMutableArray *createdArr = [[NSMutableArray alloc]init];

NSDateComponents *comps = [[NSDateComponents alloc] init];
[comps setDay:10];
[comps setMonth:10];
[comps setYear:1910];
NSDate *oldDate = [[NSCalendar currentCalendar] dateFromComponents:comps];

NSRange searchRange = NSMakeRange(0,str1.length);
NSRange foundRange;
while (searchRange.location < str1.length) {
    searchRange.length = str1.length-searchRange.location;
    foundRange = [str1 rangeOfString:@"summary =" options:nil range:searchRange];
    if (foundRange.location != NSNotFound) {
        // found an occurrence of the substring! do stuff here
NSString * newString = [str1 substringWithRange:NSMakeRange(foundRange.location+11, 40)];
NSArray *substrings = [newString componentsSeparatedByString:@";"];
NSString *first = [substrings objectAtIndex:0];
NSString * lastString = [first substringWithRange:NSMakeRange(0, first.length-1)];

//NSLog(@"%@",lastString);
[titleArr addObject:lastString];
  searchRange.location = foundRange.location+foundRange.length;
    } else {
        // no more substring to find
        break;
    }
}



NSRange searchRangeS = NSMakeRange(0,str1.length);
NSRange foundRangeS;
while (searchRangeS.location < str1.length) {
    searchRangeS.length = str1.length-searchRangeS.location;
    foundRangeS = [str1 rangeOfString:@"start =" options:nil range:searchRangeS];
    if (foundRangeS.location != NSNotFound) {
        // found an occurrence of the substring! do stuff here
NSString * newStringS = [str1 substringWithRange:NSMakeRange(foundRangeS.location+50, 40)];
NSArray *substringsS = [newStringS componentsSeparatedByString:@";"];
NSString *firstS = [substringsS objectAtIndex:0];
NSString * lastStringS = [firstS substringWithRange:NSMakeRange(0, firstS.length-7)];
//NSString * lastStringformatted = [lastStringS substringWithRange:NSMakeRange(3, lastStringS.length-14)];
//NSLog(@"lastStrings%@",lastStringS);
//NSLog(@"startStringFormatted%@",lastStringformatted);

NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
NSDate *dateFromString = [dateFormatter dateFromString:lastStringS];

if (dateFromString) {
    [startArr addObject:dateFromString];
   // NSLog(@"startDate%@",dateFromString);

}
else {
    [startArr addObject:oldDate];
}
  searchRangeS.location = foundRangeS.location+foundRangeS.length;
    } else {
        // no more substring to find
        break;
    }
}



NSRange searchRangeE = NSMakeRange(0,str1.length);
NSRange foundRangeE;
while (searchRangeE.location < str1.length) {
    searchRangeE.length = str1.length-searchRangeE.location;
    foundRangeE = [str1 rangeOfString:@"end =" options:nil range:searchRangeE];
    if (foundRangeE.location != NSNotFound) {
        // found an occurrence of the substring! do stuff here
NSString * newStringE = [str1 substringWithRange:NSMakeRange(foundRangeE.location+23, 50)];
NSArray *substringsE = [newStringE componentsSeparatedByString:@";"];
NSString *firstE = [substringsE objectAtIndex:0];
NSString * lastStringE = [firstE substringWithRange:NSMakeRange(25, firstE.length-31)];
//NSString * lastStringformatted = [lastStringS substringWithRange:NSMakeRange(3, lastStringS.length-14)];
//NSLog(@"lastStrings%@",lastStringS);
//NSLog(@"startStringFormatted%@",lastStringformatted);

NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
NSDate *dateFromString = [dateFormatter dateFromString:lastStringE];
//NSLog(@"lse %@",lastStringE);
if (dateFromString) {
    [endArr addObject:dateFromString];
  //  NSLog(@"endDate %@",dateFromString);

}
else {
   [endArr addObject:oldDate];
}
//NSLog(@"%@",lastStringE);

  searchRangeE.location = foundRangeE.location+foundRangeE.length;
    } else {
        // no more substring to find
        break;
    }
}


NSRange searchRangeC = NSMakeRange(0,str1.length);
NSRange foundRangeC;
while (searchRangeC.location < str1.length) {
    searchRangeC.length = str1.length-searchRangeC.location;
    foundRangeC = [str1 rangeOfString:@"created =" options:nil range:searchRangeC];
    if (foundRangeC.location != NSNotFound) {
        // found an occurrence of the substring! do stuff here
NSString * newStringC = [str1 substringWithRange:NSMakeRange(foundRangeC.location, 50)];
NSArray *substringsC = [newStringC componentsSeparatedByString:@","];
NSString *firstC = [substringsC objectAtIndex:0];
NSString * lastStringC = [firstC substringWithRange:NSMakeRange(11, firstC.length-15)];
NSArray *substrings2C = [lastStringC componentsSeparatedByString:@"."];
NSString * lastString2C = substrings2C[0];

//NSString * lastStringformatted = [lastStringS substringWithRange:NSMakeRange(3, lastStringS.length-14)];
//NSLog(@"lastStrings%@",lastStringS);
//NSLog(@"startStringFormatted%@",lastStringformatted);

NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
NSDate *dateFromString = [dateFormatter dateFromString:lastString2C];
NSLog(@"lsc %@",lastString2C);
if (dateFromString) {
    [createdArr addObject:dateFromString];
    NSLog(@"createdDate %@",dateFromString);

}
else {
    [createdArr addObject:oldDate];
}
//NSLog(@"%@",lastStringE);

  searchRangeC.location = foundRangeC.location+foundRangeC.length;
    } else {
        // no more substring to find
        break;
    }
}








if (titleArr.count > 0) {
    
[titleArr removeObjectAtIndex:titleArr.count-1];
}
NSLog(@"titlecount: %lu", (unsigned long)titleArr.count);
NSLog(@"startcount: %lu", (unsigned long)startArr.count);
NSLog(@"endcount: %lu", (unsigned long)endArr.count);
NSLog(@"createdCount: %lu", (unsigned long)createdArr.count);




    
    NSString *ownerString = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"handle"];
    NSMutableArray *googleCalEvs = [[NSMutableArray alloc] init];
    
if (titleArr.count == startArr.count && startArr.count == endArr.count) {
    
int countNumEvs = 0;
for (int i = 0; i < titleArr.count; i++) {
//if (countNumEvs > 398) {
//    break;
//}
    NSString *titleString = titleArr[i];
    NSDate *startDate = startArr[i];
    NSDate *endDate = endArr[i];
    
    if (titleString && startDate && endDate) {
    

    
    if (([startDate timeIntervalSinceReferenceDate] > [nowDate timeIntervalSinceReferenceDate]) && ([endDate timeIntervalSinceReferenceDate] > [nowDate timeIntervalSinceReferenceDate])) {
    
        eventObject *object = [[eventObject alloc] init];
   
        object.titleString = titleString;
        object.start = startDate;
        object.end = endDate;
        

        NSLog(@"title string adding %@", object.titleString);

        countNumEvs++;
        [googleCalEvs addObject:object];
    
    
    }
    }
}




NSString *valueToSave = @"Yes";
NSDate *d1 = [NSDate date];
[[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"importedFromGoogle"];
[[NSUserDefaults standardUserDefaults] setObject:d1 forKey:@"modifiedDateGoogle"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

NSData *eventsAsData = [userDefaults objectForKey:@"events"];
NSArray *eventsArray = [NSKeyedUnarchiver unarchiveObjectWithData:eventsAsData];

NSMutableArray *eventsArrayMutable = [NSMutableArray arrayWithArray:eventsArray];
        [eventsArrayMutable addObjectsFromArray:googleCalEvs];
    
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:eventsArrayMutable];

        [userDefaults setObject:data forKey:@"events"];


[[NSUserDefaults standardUserDefaults] synchronize];



}
//NSLog(@"%@",str1);
        });
}
}


-(void)accessTokenWasRevoked{
    // Remove all calendars from the array.
    [_arrGoogleCalendars removeAllObjects];
    _arrGoogleCalendars = nil;
    

}


-(void)errorOccuredWithShortDescription:(NSString *)errorShortDescription andErrorDetails:(NSString *)errorDetails{
    // Just log the error messages.
   // NSLog(@"%@", errorShortDescription);
   // NSLog(@"%@", errorDetails);
}


-(void)errorInResponseWithBody:(NSString *)errorMessage{
    // Just log the error message.
   // NSLog(@"herr%@",errorMessage);
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 8 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
NSMutableArray *titleArr = [[NSMutableArray alloc]init];
NSMutableArray *startArr = [[NSMutableArray alloc]init];
NSMutableArray *endArr = [[NSMutableArray alloc]init];
NSMutableArray *createdArr = [[NSMutableArray alloc]init];


NSDateComponents *comps = [[NSDateComponents alloc] init];
[comps setDay:10];
[comps setMonth:10];
[comps setYear:1910];
NSDate *oldDate = [[NSCalendar currentCalendar] dateFromComponents:comps];

NSDate *nowDate = [NSDate date];



//NSLog(@"%@",errorMessage);

NSRange searchRange = NSMakeRange(0,errorMessage.length);
NSRange foundRange;
while (searchRange.location < errorMessage.length) {
    searchRange.length = errorMessage.length-searchRange.location;
    foundRange = [errorMessage rangeOfString:@"\"summary\"" options:nil range:searchRange];
    if (foundRange.location != NSNotFound) {
        // found an occurrence of the substring! do stuff here
NSString * newString = [errorMessage substringWithRange:NSMakeRange(foundRange.location+12, 40)];
NSArray *substrings = [newString componentsSeparatedByString:@","];
NSString *first = [substrings objectAtIndex:0];
NSString * lastString = [first substringWithRange:NSMakeRange(0, first.length-1)];

//NSLog(@"%@",lastString);
[titleArr addObject:lastString];
  searchRange.location = foundRange.location+foundRange.length;
    } else {
        // no more substring to find
        break;
    }
}


NSRange searchRangeS = NSMakeRange(0,errorMessage.length);
NSRange foundRangeS;
while (searchRangeS.location < errorMessage.length) {
    searchRangeS.length = errorMessage.length-searchRangeS.location;
    foundRangeS = [errorMessage rangeOfString:@"\"start\"" options:nil range:searchRangeS];
    if (foundRangeS.location != NSNotFound) {
        // found an occurrence of the substring! do stuff here
NSString * newStringS = [errorMessage substringWithRange:NSMakeRange(foundRangeS.location+25, 40)];
NSArray *substringsS = [newStringS componentsSeparatedByString:@","];
NSString *firstS = [substringsS objectAtIndex:0];
NSString * lastStringS = [firstS substringWithRange:NSMakeRange(0, firstS.length-1)];

NSString * lastStringformatted = [firstS substringWithRange:NSMakeRange(3, lastStringS.length-14)];
//NSLog(@"startStringFormatted%@",lastStringformatted);

NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
NSDate *dateFromString = [dateFormatter dateFromString:lastStringformatted];
//NSLog(@"startDate%@",dateFromString);

if (dateFromString) {
    [startArr addObject:dateFromString];
}
else {
    [startArr addObject:oldDate];
}
  searchRangeS.location = foundRangeS.location+foundRangeS.length;
    } else {
        // no more substring to find
        break;
    }
}

NSRange searchRangeE = NSMakeRange(0,errorMessage.length);
NSRange foundRangeE;
while (searchRangeE.location < errorMessage.length) {
    searchRangeE.length = errorMessage.length-searchRangeE.location;
    foundRangeE = [errorMessage rangeOfString:@"\"end\"" options:nil range:searchRangeE];
    if (foundRangeE.location != NSNotFound) {
        // found an occurrence of the substring! do stuff here
NSString * newStringE = [errorMessage substringWithRange:NSMakeRange(foundRangeE.location+23, 40)];
NSArray *substringsE = [newStringE componentsSeparatedByString:@","];
NSString *firstE = [substringsE objectAtIndex:0];
NSString * lastStringE = [firstE substringWithRange:NSMakeRange(0, firstE.length-1)];

//NSLog(@"%@",lastStringE);
NSString * lastStringformatted = [firstE substringWithRange:NSMakeRange(3, lastStringE.length-14)];
//NSLog(@"endStringFormatted%@",lastStringformatted);

NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
NSDate *dateFromString = [dateFormatter dateFromString:lastStringformatted];
//NSLog(@"endDate%@",dateFromString);

if (dateFromString) {
    [endArr addObject:dateFromString];
}
else {
    [endArr addObject:oldDate];
}
  searchRangeE.location = foundRangeE.location+foundRangeE.length;
    } else {
        // no more substring to find
        break;
    }
}

NSRange searchRangeC = NSMakeRange(0,errorMessage.length);
NSRange foundRangeC;
while (searchRangeC.location < errorMessage.length) {
    searchRangeC.length = errorMessage.length-searchRangeC.location;
    foundRangeC = [errorMessage rangeOfString:@"\"created\"" options:nil range:searchRangeC];
    if (foundRangeC.location != NSNotFound) {
        // found an occurrence of the substring! do stuff here
NSString * newStringC = [errorMessage substringWithRange:NSMakeRange(foundRangeC.location, 50)];
NSArray *substringsC = [newStringC componentsSeparatedByString:@","];
NSString *firstC = [substringsC objectAtIndex:0];
NSString * lastStringC = [firstC substringWithRange:NSMakeRange(12, firstC.length-18)];
//NSArray *substrings2C = [lastStringC componentsSeparatedByString:@"."];
//NSString * lastString2C = substrings2C[0];

//NSString * lastStringformatted = [lastStringS substringWithRange:NSMakeRange(3, lastStringS.length-14)];
//NSLog(@"lastStrings%@",lastStringS);
//NSLog(@"startStringFormatted%@",lastStringformatted);

NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
NSDate *dateFromString = [dateFormatter dateFromString:lastStringC];
NSLog(@"lsc %@",lastStringC);
if (dateFromString) {
    [createdArr addObject:dateFromString];
    NSLog(@"createdDate %@",dateFromString);

}
else {
    [createdArr addObject:oldDate];
}
//NSLog(@"%@",lastStringE);

  searchRangeC.location = foundRangeC.location+foundRangeC.length;
    } else {
        // no more substring to find
        break;
    }
}











if (titleArr.count > 0) {
    
[titleArr removeObjectAtIndex:0];
}
NSLog(@"titlecountEr: %lu", (unsigned long)titleArr.count);
NSLog(@"startcountEr: %lu", (unsigned long)startArr.count);
NSLog(@"endcountEr: %lu", (unsigned long)endArr.count);
NSLog(@"createdCount: %lu", (unsigned long)createdArr.count);





    
    NSString *ownerString = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"handle"];
    NSMutableArray *googleCalEvs = [[NSMutableArray alloc] init];
if (titleArr.count == startArr.count && startArr.count == endArr.count) {
    
    int countNumEvs = 0;

for (int i = 0; i < titleArr.count; i++) {
if (countNumEvs > 398) {
    break;
}
    NSString *titleString = titleArr[i];
    NSDate *startDate = startArr[i];
    NSDate *endDate = endArr[i];
    
    if (titleString && startDate && endDate) {
    

    
    if (([startDate timeIntervalSinceReferenceDate] > [nowDate timeIntervalSinceReferenceDate]) && ([endDate timeIntervalSinceReferenceDate] > [nowDate timeIntervalSinceReferenceDate])) {
            eventObject *object = [[eventObject alloc] init];
       
            object.titleString = titleString;
            object.start = startDate;
            object.end = endDate;
        

            NSLog(@"title string adding %@", object.titleString);

            countNumEvs++;
            [googleCalEvs addObject:object];
    
    
    }
    }
}



NSLog(@"finito");

NSString *valueToSave = @"Yes";
NSDate *d1 = [NSDate date];
[[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"importedFromGoogle"];
[[NSUserDefaults standardUserDefaults] setObject:d1 forKey:@"modifiedDateGoogle"];

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

NSData *eventsAsData = [userDefaults objectForKey:@"events"];
NSArray *eventsArray = [NSKeyedUnarchiver unarchiveObjectWithData:eventsAsData];

NSMutableArray *eventsArrayMutable = [NSMutableArray arrayWithArray:eventsArray];
        [eventsArrayMutable addObjectsFromArray:googleCalEvs];
    
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:eventsArrayMutable];

        [userDefaults setObject:data forKey:@"events"];

[[NSUserDefaults standardUserDefaults] synchronize];

[self performSegueWithIdentifier:@"justSyncedGoogle" sender:self];


}
//NSLog(@"%@",str1);
        });
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
         if([segue.identifier isEqualToString:@"justSyncedGoogle"]){
            syncViewController *vc = [segue destinationViewController];
            vc.justSyncedGoogle = @"Yes";

         }
         if([segue.identifier isEqualToString:@"alreadySyncedGoogle"]){
            syncViewController *vc = [segue destinationViewController];
            vc.alreadySyncedGoogle = @"Yes";
         }

}


@end
