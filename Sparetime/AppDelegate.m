//
//  AppDelegate.m
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import "AppDelegate.h"
#import "eventObject.h"
#import <EventKitUI/EventKitUI.h>
@import Firebase;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FIRApp configure];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36", @"UserAgent", nil];
 [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];

    
    NSString *importedAppleCheck = [[NSUserDefaults standardUserDefaults]
    stringForKey:@"importedFromApple"];
    
    NSDate *myDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"modifedDate"];

    
    if (importedAppleCheck && myDate) {


        appleCalEvs = [[NSMutableArray alloc] init];
        EKEventStore *store = [[EKEventStore alloc] init];
        NSMutableArray *recordsToUpload = [[NSMutableArray alloc] init];

        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if(granted) {

                NSDate* startDate = [NSDate date];
                // NSDate* startDate = date  whatever value you want
                NSDateComponents *comp = [NSDateComponents new];
                //int numberOfDaysInAWeek = 7;
                //int weeks = 1;
                //comp.day = weeks * numberOfDaysInAWeek*i;
                comp.weekOfYear = 13;
                NSCalendar *calendar = [NSCalendar currentCalendar];

                NSDate *endDate = [calendar dateByAddingComponents:comp toDate:startDate options:0];
                
                //NSDate *endDate = [NSDate distantFuture];
                NSArray *calendarArray = store.calendars;
           
           
               // NSDate* endDate =  whatever value you want
                NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:calendarArray];
                    NSPredicate *p1 = [NSPredicate predicateWithFormat:@"lastModifiedDate > %@", myDate];

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
//                if (countNumEvs > 398) {
//                    break;
//                }

                    if ((!event.allDay) && ([event.lastModifiedDate compare: myDate] == NSOrderedDescending)) {
                        //NSLog(@"Event Title:%@", event.title);
                       //NSLog(@"Event StartDate:%@", event.startDate);
                      // NSLog(@"Event EndDate:%@", event.endDate);
                      // NSLog(@"Event Location:%@", event.location);
                    //NSLog(@"All Day?: %@", event.allDay ? @"YES" : @"NO");
                        eventObject *object = [[eventObject alloc] init];
                        object.titleString = event.title;
                        object.start = event.startDate;
                        object.end = event.endDate;

                        NSLog(@"title string is %@", object.titleString);

                                countNumEvs++;

                        [appleCalEvs addObject:object];

                    }

                }
           
            }
        }];


        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

            //[[NSNotificationCenter defaultCenter]
            //    postNotificationName:@"TestNotification"


            NSLog(@"completed");

            NSDate *d1 = [NSDate date];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

            [userDefaults setObject:d1 forKey:@"modifedDate"];
            
            if (appleCalEvs) {
                NSData *eventsAsData = [userDefaults objectForKey:@"events"];
                NSArray *eventsArray = [NSKeyedUnarchiver unarchiveObjectWithData:eventsAsData];


                NSMutableArray *eventsArrayMutable = [NSMutableArray arrayWithArray:eventsArray];
                [eventsArrayMutable addObjectsFromArray:appleCalEvs];
            
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:eventsArrayMutable];

                [userDefaults setObject:data forKey:@"events"];
                [userDefaults synchronize];
            }
        });

    }
    
    
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Sparetime"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
