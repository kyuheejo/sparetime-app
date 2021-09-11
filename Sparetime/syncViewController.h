//
//  syncViewController.h
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleOAuth.h"

NS_ASSUME_NONNULL_BEGIN

@interface syncViewController : UIViewController {
    IBOutlet UIView *googleView;
    IBOutlet UIView *appleView;
    NSMutableArray *appleCalEvents;
    UIActivityIndicatorView *ac;
    UILabel *lblLoading;
    IBOutlet UIButton *backButton;

}

@property (strong, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) IBOutlet NSString *justSyncedGoogle;
@property (strong, nonatomic) IBOutlet NSString *alreadySyncedGoogle;
@property (strong, nonatomic) IBOutlet NSString *fromSettings;

-(IBAction)appleAction:(id)sender;
-(IBAction)googleAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
