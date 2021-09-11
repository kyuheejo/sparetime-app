//
//  eventsTableView.h
//  Sparetime
//
//  Created by Brian Fisher on 2/26/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface eventsTableView : UITableViewController {

    NSMutableArray *arr;
    
    UIActivityIndicatorView *ac;
    UILabel *lblLoading;

}
@property (strong, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) FIRDatabaseReference *refEvents;
@property (strong, nonatomic) FIRStorage *storage;
@property (strong, nonatomic) FIRStorageReference *storageRef;
@property (strong, nonatomic) FIRStorageReference *imagesRef;
@property (strong, nonatomic) FIRDatabaseReference *updateRefEvs;
@property (strong, nonatomic) FIRDatabaseReference *refNumClicks;



@end

NS_ASSUME_NONNULL_END
