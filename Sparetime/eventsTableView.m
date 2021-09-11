//
//  eventsTableView.m
//  Sparetime
//
//  Created by Brian Fisher on 2/26/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import "eventsTableView.h"
#import "activityObject.h"
#import "AppDelegate.h"
#import "eventObject.h"
#import <EventKit/EventKit.h>
@interface eventsTableView ()

@end

@implementation eventsTableView


-(void)fetchData {

    NSArray *myFilters = [[NSUserDefaults standardUserDefaults]
            objectForKey:@"myFilters"];

    self.refEvents = [[[FIRDatabase database] reference] child:@"events"];
   // FIRStorage *storage = [FIRStorage storage];
    //FIRStorageReference *storageRef = [storage reference];
    [self.refEvents observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {

        if (snapshot.childrenCount > 0){
        arr = [[NSMutableArray alloc] initWithCapacity:snapshot.childrenCount];
            NSLog(@"joe");
            for (FIRDataSnapshot *child in snapshot.children) {
                activityObject *object = [[activityObject alloc] init];

                NSDictionary *savedEvent = [child value];
                NSString *titleString = [savedEvent objectForKey:@"titleString"];
                object.titleString = titleString;

                object.descriptionString = [savedEvent objectForKey:@"descriptionString"];
                object.typeString = [savedEvent objectForKey:@"typeString"];
                object.locationString = [savedEvent objectForKey:@"locationString"];
                object.imageNamed = [savedEvent objectForKey:@"imageNamed"];
                
                NSDateFormatter *dateFormat = [NSDateFormatter new];
                [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
                NSString *startDateString = [savedEvent objectForKey:@"startDate"];
                object.startDate = [dateFormat dateFromString:startDateString];
                NSString *endDateString = [savedEvent objectForKey:@"endDate"];
                object.endDate = [dateFormat dateFromString:endDateString];
                object.eventId = [savedEvent objectForKey:@"eventId"];
                object.priceString = [savedEvent objectForKey:@"priceString"];
                object.urlString = [savedEvent objectForKey:@"urlString"];
                object.numClicks = [savedEvent objectForKey:@"numClicks"];
                object.tagString = [savedEvent objectForKey:@"tagString"];
                NSString *dateValid = @"Yes";
                NSDate *today = [NSDate date];
                if ([object.startDate timeIntervalSinceReferenceDate] < [today timeIntervalSinceReferenceDate]) {
                    dateValid = @"No";
                }
//                FIRStorageReference *imRef = [_imagesRef child:object.imageNamed];
//
//
//                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//                [imRef dataWithMaxSize:2 * 1024 * 1024 completion:^(NSData *data, NSError *error){
//                    if (error != nil) {
//                        NSLog(@"wegotanerror");
//                        // Uh-oh, an error occurred!
//                    } else {
//                        // Data for "images/island.jpg" is returned
//                        NSLog(@"aaronaaron");
//                        object.picture = data;
//                        //picImage.image = [UIImage imageWithData:object.picture];
//
//                    }
//                }];
                //NSLog(@"desc string %@",object.descriptionString);
                
                NSData *eventsAsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"events"];
                NSArray *eventsArray = [NSKeyedUnarchiver unarchiveObjectWithData:eventsAsData];
                NSString *testString = @"Good";
                for (int i = 0; i < eventsArray.count; i++) {
                    NSLog(@"yeeeeert");
                    eventObject *calEv = eventsArray[i];
                    NSLog(@"calev start date %@", calEv.start);
                    NSLog(@"object start date %@", object.startDate);
                    NSLog(@"calev end date %@", calEv.end);
                    NSLog(@"object end date %@", object.endDate);

//
//
//                    [date1 compare:date2] == NSOrderedDescending
//                    [date1 compare:date2] == NSOrderedAscending
//
//                    if (([object.startDate compare:calEv.start] == NSOrderedAscending && [object.endDate compare:calEv.end] == NSOrderedDescending) || ([object.startDate compare:calEv.start] == NSOrderedAscending && [object.startDate compare:calEv.end] == NSOrderedDescending) || ([object.endDate compare:calEv.start] == NSOrderedAscending && [object.endDate compare:calEv.end] == NSOrderedDescending) || ([calEv.start compare:object.startDate] == NSOrderedDescending && [calEv.end compare:object.endDate] == NSOrderedAscending)) {
                    
//                                    if (([object.startDate compare:calEv.start] == NSOrderedAscending && [object.endDate compare:calEv.end] == NSOrderedDescending) || ([object.startDate compare:calEv.start] == NSOrderedAscending && [object.startDate compare:calEv.end] == NSOrderedDescending) || ([object.endDate compare:calEv.start] == NSOrderedAscending && [object.endDate compare:calEv.end] == NSOrderedDescending) || ([calEv.start compare:object.startDate] == NSOrderedDescending && [calEv.end compare:object.endDate] == NSOrderedAscending)) {
                    
                    if (([object.startDate timeIntervalSinceReferenceDate] > [calEv.start timeIntervalSinceReferenceDate] && [object.endDate timeIntervalSinceReferenceDate] < [calEv.end timeIntervalSinceReferenceDate]) || ([object.startDate timeIntervalSinceReferenceDate] > [calEv.start timeIntervalSinceReferenceDate] && [object.startDate timeIntervalSinceReferenceDate] < [calEv.end timeIntervalSinceReferenceDate]) || ([object.endDate timeIntervalSinceReferenceDate] > [calEv.start timeIntervalSinceReferenceDate] && [object.endDate timeIntervalSinceReferenceDate] < [calEv.end timeIntervalSinceReferenceDate]) || ([calEv.start timeIntervalSinceReferenceDate] < [object.startDate timeIntervalSinceReferenceDate] && [calEv.end timeIntervalSinceReferenceDate] > [object.endDate timeIntervalSinceReferenceDate])) {

                        NSLog(@"bad");
                        testString = @"Bad";
                        break;
                    
                    }
                }
                if (myFilters.count > 1 && object.tagString) {
                    if ([testString isEqualToString:@"Good"] && [dateValid isEqualToString:@"Yes"] && [myFilters containsObject:object.tagString]) {
                        [arr addObject:object];
                    }
                } else {
                    if ([testString isEqualToString:@"Good"] && [dateValid isEqualToString:@"Yes"]) {
                        [arr addObject:object];
                    }
                }
                
                
               // NSLog(@"%@",arr);
                
            }
        dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"heythereeee");
        [arr sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES]]];

        [ac stopAnimating];
        _loadingView.hidden = YES;
        [self.tableView reloadData];
        });
        
        }
    
    }];

}


-(void)fetchDataLikes {

    NSArray *myLikes = [[NSUserDefaults standardUserDefaults]
            objectForKey:@"myLikes"];


    self.refEvents = [[[FIRDatabase database] reference] child:@"events"];
   // FIRStorage *storage = [FIRStorage storage];
    //FIRStorageReference *storageRef = [storage reference];
    [self.refEvents observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {

        if (snapshot.childrenCount > 0){
        arr = [[NSMutableArray alloc] initWithCapacity:snapshot.childrenCount];
            NSLog(@"joe");
            for (FIRDataSnapshot *child in snapshot.children) {
                activityObject *object = [[activityObject alloc] init];

                NSDictionary *savedEvent = [child value];
                NSString *titleString = [savedEvent objectForKey:@"titleString"];
                object.titleString = titleString;

                object.descriptionString = [savedEvent objectForKey:@"descriptionString"];
                object.typeString = [savedEvent objectForKey:@"typeString"];
                object.locationString = [savedEvent objectForKey:@"locationString"];
                object.imageNamed = [savedEvent objectForKey:@"imageNamed"];
                
                NSDateFormatter *dateFormat = [NSDateFormatter new];
                [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
                NSString *startDateString = [savedEvent objectForKey:@"startDate"];
                object.startDate = [dateFormat dateFromString:startDateString];
                NSString *endDateString = [savedEvent objectForKey:@"endDate"];
                object.endDate = [dateFormat dateFromString:endDateString];
                object.eventId = [savedEvent objectForKey:@"eventId"];
                object.priceString = [savedEvent objectForKey:@"priceString"];
                object.tagString = [savedEvent objectForKey:@"tagString"];

//                FIRStorageReference *imRef = [_imagesRef child:object.imageNamed];
                NSString *dateValid = @"Yes";
                NSDate *today = [NSDate date];
                if ([object.startDate timeIntervalSinceReferenceDate] < [today timeIntervalSinceReferenceDate]) {
                    dateValid = @"No";
                }
//
//                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//                [imRef dataWithMaxSize:2 * 1024 * 1024 completion:^(NSData *data, NSError *error){
//                    if (error != nil) {
//                        NSLog(@"wegotanerror");
//                        // Uh-oh, an error occurred!
//                    } else {
//                        // Data for "images/island.jpg" is returned
//                        NSLog(@"aaronaaron");
//                        object.picture = data;
//                        //picImage.image = [UIImage imageWithData:object.picture];
//
//                    }
//                }];
                //NSLog(@"desc string %@",object.descriptionString);
                
                if ([myLikes containsObject:object.eventId] && [dateValid isEqualToString:@"Yes"]) {

                    [arr addObject:object];
                }
                
                
               // NSLog(@"%@",arr);
                
            }
        dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"heythereeee");
        //[arr sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES]]];

        [ac stopAnimating];
        _loadingView.hidden = YES;
        [self.tableView reloadData];
        });
        
        }
    
    }];

}


- (void)viewDidLoad {
    _storage = [FIRStorage storage];
    _storageRef = [_storage reference];
    _imagesRef = [_storageRef child:@"images"];
//    [[NSUserDefaults standardUserDefaults] setObject:@"bfishe27" forKey:@"username"];
//    [[NSUserDefaults standardUserDefaults] setObject:@"bfishe27@jhu.edu" forKey:@"email"];

    [[NSUserDefaults standardUserDefaults] synchronize];
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
        lblLoading.text = @"Loading...";
        lblLoading.textColor = [UIColor whiteColor];
        lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
        lblLoading.textAlignment = NSTextAlignmentCenter;
        [_loadingView addSubview:lblLoading];
     
        [self.view addSubview:_loadingView];
        [self.view bringSubviewToFront:_loadingView];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if ([appDelegate.isLikes isEqualToString:@"Yes"]) {
            [self fetchDataLikes];
        } else {
            [self fetchData];
        }

    });
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
     return arr.count;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 385;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    activityObject *object = [arr objectAtIndex:indexPath.row];
    UIImageView *picImage = (UIImageView*) [cell viewWithTag:1];
    picImage.image = nil;
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [activityIndicator setCenter: picImage.center];
            [activityIndicator startAnimating];
            [cell.contentView addSubview:activityIndicator];
//    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//activityIndicator.center = picImage.center;
//activityIndicator.hidesWhenStopped = YES;
//[picImage addSubview:activityIndicator];
//[activityIndicator startAnimating];
    FIRStorageReference *imRef = [_imagesRef child:object.imageNamed];


                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                [imRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error){
                    if (error != nil) {
                        NSLog(@"wegotanerror");
                        // Uh-oh, an error occurred!
                    } else {
                        // Data for "images/island.jpg" is returned
                        NSLog(@"aaronaaron");
                        object.picture = data;
                        [activityIndicator removeFromSuperview];
//                        activityIndicator.hidden = YES;
                        picImage.image = [UIImage imageWithData:object.picture];

                    }
                }];
//    UIImage *zeroImage = [[UIImage alloc]init];
//    if(![object.imageNamed isEqualToString:@""] && object.imageNamed)
//    {
//        zeroImage = [self decodeBase64ToImage:object.imageNamed];
//    }
//    picImage.image = zeroImage;
    picImage.layer.cornerRadius = 10;
    picImage.clipsToBounds = YES;
    UILabel *titleLabel = (UILabel*) [cell viewWithTag:3];
    titleLabel.text = object.titleString;
    //UILabel *titleLabel = (UILabel*) [cell viewWithTag:3];

    UILabel *dateLabel = (UILabel*) [cell viewWithTag:2];
    NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"E, MMM d h:mm a"];
    NSLog(@"thestartdate %@", object.startDate);
    NSString *startString = [formatter stringFromDate:object.startDate];
    NSDateFormatter * formatter2 =  [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"h:mm a"];
    NSString *endString = [formatter2 stringFromDate:object.endDate];
    NSString *dateString = startString;


    dateLabel.text = dateString;
    
    UILabel *descriptionLabel = (UILabel*) [cell viewWithTag:4];
    descriptionLabel.text = object.descriptionString;
    
    UILabel *typeLabel = (UILabel*) [cell viewWithTag:10];
    typeLabel.text = object.typeString;
    
    UILabel *durationLabel = (UILabel*) [cell viewWithTag:7];
    NSTimeInterval timeDifference = [object.endDate timeIntervalSinceDate:object.startDate];
    int hours = (int)timeDifference / 3600;
    if (hours > 1) {
        durationLabel.text = [NSString stringWithFormat:@"%d hours",hours];
    } else
        durationLabel.text = [NSString stringWithFormat:@"%d hour",hours];
    
    UILabel *locationLabel = (UILabel*) [cell viewWithTag:9];
    locationLabel.text = object.locationString;
    
    UILabel *priceLabel = (UILabel*) [cell viewWithTag:12];
    priceLabel.text = object.priceString;
    
    UIButton *likeButton = (UIButton*) [cell viewWithTag:11];
    NSArray *myLikes = [[NSUserDefaults standardUserDefaults]
            objectForKey:@"myLikes"];

    if ([myLikes containsObject:object.eventId]) {
        [likeButton setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    } else {
        [likeButton setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }

    
    //likeButton.imageView = object.startDate;
    
    // Configure the cell...
    
    return cell;
}

-(UITableViewCell *)parentCellForView:(id)theView
{
    id viewSuperView = [theView superview];
    while (viewSuperView != nil) {
        if ([viewSuperView isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell *)viewSuperView;
        }
        else {
            viewSuperView = [viewSuperView superview];
        }
    }
    return nil;
}

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    activityObject *object = [arr objectAtIndex:indexPath.row];
    
    int voteNum = [object.numClicks intValue];
    voteNum += 1;
    NSNumber *voteNumberInstance = [NSNumber numberWithInt:voteNum];

    //if (voteNumberInstance == countArray[indexPath.row]) {
    
    self.refNumClicks = [[[[FIRDatabase database] reference] child:@"events"] child:object.eventId];
    [[self.refNumClicks child:@"numClicks"] setValue:voteNumberInstance];
    
    
    
    NSString *urlString = object.urlString;
    NSLog(@"url String %@", urlString);
    if (urlString) {
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(IBAction)likeClicked:(id)sender {

    UIButton *butn = (UIButton *)sender;
    UITableViewCell *cell = [self parentCellForView:butn];
    if (cell != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        activityObject *object = [arr objectAtIndex:indexPath.row];
        
        NSArray *myLikes = [[NSUserDefaults standardUserDefaults]
            objectForKey:@"myLikes"];
        NSString *usernameString = [[NSUserDefaults standardUserDefaults]
                stringForKey:@"username"];
        NSString *emailString = [[NSUserDefaults standardUserDefaults]
                stringForKey:@"email"];
        self.updateRefEvs = [[[FIRDatabase database] reference] child:@"events"];

        if ([myLikes containsObject:object.eventId]) {
            [butn setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
            NSMutableArray *mutableLikes = [NSMutableArray arrayWithArray:myLikes];
            [mutableLikes removeObject:object.eventId];
            [[NSUserDefaults standardUserDefaults] setObject:mutableLikes forKey:@"myLikes"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[[[self.updateRefEvs child:object.eventId] child:@"likers"] child:usernameString] setValue:nil];
            
            NSData *eventsAsData = [userDefaults objectForKey:@"savedAppleEvs"];
            NSArray *savedAppleEvs = [NSKeyedUnarchiver unarchiveObjectWithData:eventsAsData];

            NSString *appleCalIdToRemove;
            for (int i = 0; i < savedAppleEvs.count; i++) {
                activityObject *obj = savedAppleEvs[i];
                if ([obj.titleString isEqualToString:object.titleString] && obj.startDate == object.startDate && obj.endDate == object.endDate) {
                    appleCalIdToRemove = obj.appleCalId;
                    NSLog(@"apple cal id to remove %@", appleCalIdToRemove);
                    break;
                }
            }
            if (appleCalIdToRemove.length > 0) {
                EKEventStore* store = [[EKEventStore alloc] init];
                NSLog(@"gonna remove");
                EKEvent* eventToRemove = [store eventWithIdentifier:object.appleCalId];
                if (eventToRemove != nil) {
                    NSLog(@"we are removing");
                    NSError* error = nil;
                    [store removeEvent:eventToRemove span:EKSpanThisEvent error:&error];
                }
            }


        } else {
            [butn setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
            NSMutableArray *mutableLikes = [NSMutableArray arrayWithArray:myLikes];
            [mutableLikes addObject:object.eventId];
            [[NSUserDefaults standardUserDefaults] setObject:mutableLikes forKey:@"myLikes"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[[[self.updateRefEvs child:object.eventId] child:@"likers"] child:usernameString] setValue:emailString];
            EKEventStore *store = [EKEventStore new];
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                if (!granted) { return; }
                    EKEvent *event = [EKEvent eventWithEventStore:store];
                    event.title = object.titleString;
                    event.startDate = object.startDate;
                    event.endDate = object.endDate;
                    event.notes = object.descriptionString;
                    event.location = object.locationString;
                    event.calendar = [store defaultCalendarForNewEvents];
                    NSError *err = nil;
                    [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                    NSString *savedEventId = event.eventIdentifier;
                    NSLog(@"saved event id is %@",savedEventId);
                
                
                
                    NSData *eventsAsData = [userDefaults objectForKey:@"savedAppleEvs"];
                    NSArray *savedAppleEvs = [NSKeyedUnarchiver unarchiveObjectWithData:eventsAsData];

                    NSMutableArray *mutableAppleEvs = [NSMutableArray arrayWithArray:savedAppleEvs];
                    object.appleCalId = savedEventId;
                    [mutableAppleEvs addObject:object];
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mutableAppleEvs];

                    [userDefaults setObject:data forKey:@"savedAppleEvs"];
                    [userDefaults synchronize];
                    [[NSUserDefaults standardUserDefaults] synchronize];
            }];

         }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"likes"]){
         AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
         appDelegate.isLikes = @"Yes";

    }
    if([segue.identifier isEqualToString:@"back"]){
         AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
         appDelegate.isLikes = @"No";

    }
}


@end
