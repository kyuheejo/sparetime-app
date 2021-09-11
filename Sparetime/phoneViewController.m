//
//  phoneViewController.m
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import "phoneViewController.h"

@interface phoneViewController ()

@end

@implementation phoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSString *phone = [[NSUserDefaults standardUserDefaults] stringForKey:@"phone"];
    if (phone) {
        phoneField.text = phone;
    }
    // Do any additional setup after loading the view.
}
-(IBAction)submitPhone:(id)sender {
    if (phoneField.text == NULL || phoneField.text.length != 10) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setObject:phoneField.text forKey:@"phone"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.ref = [[[[FIRDatabase database] reference] child:@"users"] child:username];

        NSDictionary *ev = @{
            @"email": email,
            @"phone": phoneField.text
        };
    NSLog(@"saving user");
    [self.ref updateChildValues:ev];
    [self performSegueWithIdentifier:@"submitSegue" sender:self];
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
