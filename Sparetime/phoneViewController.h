//
//  phoneViewController.h
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface phoneViewController : UIViewController{
    IBOutlet UITextField *phoneField;
}
@property (strong, nonatomic) FIRDatabaseReference *ref;
-(IBAction)submitPhone:(id)sender;


@end

NS_ASSUME_NONNULL_END
