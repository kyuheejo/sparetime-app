//
//  settingsViewController.m
//  Sparetime
//
//  Created by Brian Fisher on 2/29/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import "settingsViewController.h"
#import "syncViewController.h"

@interface settingsViewController ()

@end

@implementation settingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)addEvent:(id)sender {

    NSURL *url = [NSURL URLWithString:@"https://docs.google.com/forms/d/e/1FAIpQLSeQFMu6K_Z0HsR_vh76PwtLhgqqm-MFgSG-XrpBuiBFoNZjLg/viewform"];
        [[UIApplication sharedApplication] openURL:url];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"sync"]){
            syncViewController *vc = [segue destinationViewController];
            vc.fromSettings = @"Yes";
    }
}


@end
