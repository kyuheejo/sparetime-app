//
//  initialViewController.h
//  Sparetime
//
//  Created by Brian Fisher on 2/29/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleOAuth.h"

NS_ASSUME_NONNULL_BEGIN

@interface initialViewController : UIViewController<GoogleOAuthDelegate>

@end

NS_ASSUME_NONNULL_END
