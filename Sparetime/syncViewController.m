//
//  syncViewController.m
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import "syncViewController.h"
#import "eventObject.h"
#import <EventKitUI/EventKitUI.h>

@interface syncViewController ()

@end

@implementation syncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (self.fromSettings) {
        backButton.hidden = YES;
    }
    
    googleView.layer.cornerRadius = 10;
    googleView.clipsToBounds = YES;
    
    appleView.layer.cornerRadius = 10;
    appleView.clipsToBounds = YES;
    
    if (_justSyncedGoogle) {
    dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"already imported");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Google Calendar Imported" message:@"Events added to your Google Calendar will now be synced with Sparetime!." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

            alert.bounds = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);
            [alert show];
        });
        }
    
    // Do any additional setup after loading the view.
}



-(IBAction)appleAction:(id)sender {
    NSLog(@"Apple");

    NSString *importedAppleCheck = [[NSUserDefaults standardUserDefaults]
        stringForKey:@"importedFromApple"];
    appleCalEvents = [[NSMutableArray alloc] init];
    
    if (importedAppleCheck.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"already imported");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Apple Calendar already Imported" message:@"Events added to your Apple Calendar will now be synced with Sparetime!." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

            alert.bounds = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);
            [alert show];
            return;
            });
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
    

    EKEventStore *store = [[EKEventStore alloc] init];
    NSMutableArray *recordsToUpload = [[NSMutableArray alloc] init];

    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if(granted) {
    
            NSDate* startDate = [NSDate date];
            // NSDate* startDate = date  whatever value you want
       

            NSDate *endDate = [NSDate dateWithTimeInterval:(13*7*24*60*60) sinceDate:startDate];
            //thirteen weeks in future
            NSArray *calendarArray = store.calendars;
       
       
           // NSDate* endDate =  whatever value you want
            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:calendarArray];
            NSArray *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            //NSLog(@"%@",eventList);
        
            NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                sortDescriptorWithKey:@"startDate"
                ascending:YES
                selector:@selector(compare:)];
            NSArray *sortedEventArray = [eventList
                sortedArrayUsingDescriptors:@[dateDescriptor]];
        
            int countNumEvs = 0;
            for (EKEvent *event in sortedEventArray) {
//            if (countNumEvs > 398) {
//                break;
//            }
                

                if (!event.allDay) {
                eventObject *object = [[eventObject alloc] init];
                    //NSLog(@"Event Title:%@", event.title);
                    //NSLog(@"Event StartDate:%@", event.startDate);
                    // NSLog(@"Event EndDate:%@", event.endDate);
                    // NSLog(@"Event Location:%@", event.location);
                    //NSLog(@"All Day?: %@", event.allDay ? @"YES" : @"NO");
                    //NSString *randomString = [[NSProcessInfo processInfo] globallyUniqueString];
                   // CKRecordID *eventRecordId = [[CKRecordID alloc] initWithRecordName:randomString];
                    //CKRecord *eventRecord = [[CKRecord alloc] initWithRecordType:@"Events" recordID:eventRecordId];
                    //NSMutableString *data = [NSMutableString stringWithString:event.title];
                   // if ([[data substringToIndex:3] isEqualToString:@"EN."] || [[data substringToIndex:3] isEqualToString:@"AS."] ) {
                //    [data deleteCharactersInRange:NSMakeRange(0, 17)];
                //}
                    object.titleString = event.title;
                    object.start = event.startDate;
                    object.end = event.endDate;
                    

//                    eventRecord[@"title"] = event.title;
//                    eventRecord[@"location"] = event.location;
//                    eventRecord[@"start"] = event.startDate;
//                    eventRecord[@"end"] = event.endDate;
//                    eventRecord[@"owner"] = ownerString;
//
//                    eventRecord[@"members"] = @[ownerString];
//                    eventRecord[@"membersAndRequesteds"] = @[ownerString];

                    NSLog(@"the title apple is %@", object.titleString);

                    
                    [appleCalEvents addObject:object];
                    countNumEvs++;

                }

   
            }
   

        }
    }];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 8.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

        //[[NSNotificationCenter defaultCenter]
        //    postNotificationName:@"TestNotification"




     
        NSLog(@"completed");
        [ac stopAnimating];
        _loadingView.hidden = YES;
        NSString *valueToSave = @"Yes";
        NSDate *d1 = [NSDate date];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        [userDefaults setObject:valueToSave forKey:@"importedFromApple"];
        [userDefaults setObject:d1 forKey:@"modifedDate"];
        
        
        for (int i = 0; i < appleCalEvents.count; i++) {
            NSLog(@"loopapplecalevs i %@", appleCalEvents[i]);
        }
        
        NSData *eventsAsData = [userDefaults objectForKey:@"events"];
        NSArray *eventsArray = [NSKeyedUnarchiver unarchiveObjectWithData:eventsAsData];


        NSMutableArray *eventsArrayMutable = [NSMutableArray arrayWithArray:eventsArray];
        [eventsArrayMutable addObjectsFromArray:appleCalEvents];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:eventsArrayMutable];

        [userDefaults setObject:data forKey:@"events"];
        
        
        

        
        
        
//        for (int i = 0; i < eventsArrayMutable.count; i++) {
//            eventObject *obj = eventsArrayMutable[i];
//            NSString *titleString = obj.titleString;
//            NSLog(@"Title of event is: %@",titleString);
//        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Finished syncing" message:@"Apple Calendar is now synced!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
//[self performSegueWithIdentifier:@"back" sender:self];
        });


//}
    }
}
    


-(IBAction)googleAction:(id)sender {
    NSLog(@"Google");
     NSString *importedGoogleCheck = [[NSUserDefaults standardUserDefaults]
        stringForKey:@"importedFromGoogle"];
    if (importedGoogleCheck.length > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Already Imported!" message:@"You have already imported a google calendar and it will now sync all future events to Sparetime!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

        alert.bounds = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);
        [alert show];
    } else {
        [self performSegueWithIdentifier:@"googleImport" sender:self];
    }

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
