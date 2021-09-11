//
//  splashViewController.h
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//
#import "GoogleOAuth.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface splashViewController : UIViewController<GoogleOAuthDelegate> {
    IBOutlet UIButton *startButton;
}
@end

NS_ASSUME_NONNULL_END
