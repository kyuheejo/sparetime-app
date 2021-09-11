//
//  googleViewController.h
//  Sparetime
//
//  Created by Brian Fisher on 3/12/19.
//  Copyright © 2019 Fisher Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleOAuth.h"
#import "DownPicker.h"

@interface googleViewController : UIViewController <GoogleOAuthDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *calsField;
    NSMutableArray *calNamesArr;
    //IBOutlet UINavigationBar *navBar;
    UIActivityIndicatorView *ac;
    UILabel *lblLoading;
    IBOutlet UIButton *importButton;

}
@property (strong, nonatomic) DownPicker *downPicker;
@property (strong, nonatomic) IBOutlet UIView *loadingView;

- (IBAction)post:(id)sender;

@end
