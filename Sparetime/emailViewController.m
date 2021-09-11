//
//  emailViewController.m
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import "emailViewController.h"

@interface emailViewController ()

@end

@implementation emailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    if (email) {
        emailField.text = email;
    }
    // Do any additional setup after loading the view.
}

-(IBAction)submitEmail:(id)sender {
    
    if (emailField.text == NULL) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        NSArray *subStrings = [emailField.text componentsSeparatedByString:@"@"];
        if (subStrings.count != 2) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        } else {
            NSString *firstString = [subStrings objectAtIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:firstString forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:emailField.text forKey:@"email"];
            if ([emailField.text containsString:@"jhu.edu"] || [emailField.text containsString:@"jh.edu"]) {
                NSArray *filtersArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"myFilters"];
                NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
                if (filtersArray) {
                    mutableFilters = [filtersArray mutableCopy];
                }
                [mutableFilters addObject:@"jhu"];
                [[NSUserDefaults standardUserDefaults] setObject:mutableFilters forKey:@"myFilters"];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSString *phone = [[NSUserDefaults standardUserDefaults] stringForKey:@"phone"];
            if (phone) {
                self.ref = [[[[FIRDatabase database] reference] child:@"users"] child:firstString];

                NSDictionary *ev = @{
                    @"email": emailField.text,
                    @"phone": phone
                };
                NSLog(@"saving user");
                [self.ref updateChildValues:ev];
            }
            [self performSegueWithIdentifier:@"nextSegue" sender:self];
        }
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
