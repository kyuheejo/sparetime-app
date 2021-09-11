//
//  emailViewController.h
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
NS_ASSUME_NONNULL_BEGIN

@interface emailViewController : UIViewController {
    IBOutlet UITextField *emailField;
}
@property (strong, nonatomic) FIRDatabaseReference *ref;
-(IBAction)submitEmail:(id)sender;

@end

NS_ASSUME_NONNULL_END
