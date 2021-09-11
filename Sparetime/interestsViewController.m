//
//  interestsViewController.m
//  Sparetime
//
//  Created by Brian Fisher on 3/6/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import "interestsViewController.h"

@interface interestsViewController ()

@end

@implementation interestsViewController

-(IBAction)learnSomething:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"learn"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"learn"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"learn"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}


-(IBAction)blindDate:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"date"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"date"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"date"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)chatWithStrangers:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"chat"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"chat"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"chat"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)virtualParty:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"party"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"party"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"party"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)gaming:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"game"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"game"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"game"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)languageExchange:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"lang"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"lang"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"lang"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)netflix:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"Netflix"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"Netflix"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"Netflix"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)webinar:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"web"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"web"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"web"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}


-(IBAction)art:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"art"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"art"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"art"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)crafts:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"art"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"art"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"art"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)sports:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
        UIButton *button = (UIButton *)sender;

NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }    if ([filtersArray containsObject:@"spo"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"spo"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"spo"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)fitness:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"spo"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"spo"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"spo"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)travel:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"out"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"out"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"out"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)music:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"mus"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"mus"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"mus"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)performance:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"film"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"film"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"film"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)film:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"film"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"film"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"film"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)tech:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
        UIButton *button = (UIButton *)sender;

NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }    if ([filtersArray containsObject:@"tech"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"tech"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"tech"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)startups:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"tech"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"tech"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"tech"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)science:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
        UIButton *button = (UIButton *)sender;

NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }    if ([filtersArray containsObject:@"sci"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"sci"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"sci"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)professional:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"pro"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"pro"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"pro"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)government:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"gov"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"gov"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"gov"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)party:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"mus"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"mus"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"mus"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)community:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
        UIButton *button = (UIButton *)sender;

NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }    if ([filtersArray containsObject:@"com"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"com"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"com"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)culture:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"com"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"com"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"com"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)family:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"fam"]) {
       [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"fam"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"fam"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)food:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }    UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"food"]) {
        
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"food"];
    } else {
    
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    
        [mutableFilters addObject:@"food"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)fashion:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"fsh"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"fsh"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"fsh"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)beauty:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
        UIButton *button = (UIButton *)sender;

NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }    if ([filtersArray containsObject:@"fsh"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"fsh"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"fsh"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)charity:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"char"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"char"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"char"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)religion:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"rel"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"rel"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"rel"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)language:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"lng"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"lng"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"lng"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)education:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"edu"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"edu"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"edu"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}
-(IBAction)wellness:(id)sender {
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
    NSMutableArray *mutableFilters = [[NSMutableArray alloc] init];
    if (filtersArray) {
        mutableFilters = [filtersArray mutableCopy];
    }
        UIButton *button = (UIButton *)sender;

    if ([filtersArray containsObject:@"wll"]) {
    [button setImage: [[UIImage imageNamed: @"emptyhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters removeObject:@"wll"];
    } else {
    [button setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
        [mutableFilters addObject:@"wll"];
    }
    [userDefaults setObject:mutableFilters forKey:@"myFilters"];
    [userDefaults synchronize];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSArray *filtersArray = [userDefaults objectForKey:@"myFilters"];
    NSLog(@"jonsmith123456");
    for (int i = 0; i < filtersArray.count; i++) {
        NSLog(@"FILTER %d %@", i, filtersArray[i]);
    }
    if ([filtersArray containsObject:@"date"]) {
        [blindDate setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"chat"]) {
        [chatWithStrangers setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"party"]) {
        [party setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"game"]) {
        [gaming setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"lang"]) {
        [languageExchange setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"learn"]) {
        [learnSomething setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"Netflix"]) {
        [netflix setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"web"]) {
        [webinar setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    
    
    
    if ([filtersArray containsObject:@"art"]) {
        [art setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"art"]) {
        [crafts setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"spo"]) {
        [sports setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"spo"]) {
        [fitness setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"out"]) {
        [travel setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"mus"]) {
        [music setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"mus"]) {
        [party setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"film"]) {
        [performance setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"film"]) {
        [film setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"tech"]) {
        [tech setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"tech"]) {
        [startups setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"sci"]) {
        [science setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"pro"]) {
        [professional setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"com"]) {
        [community setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"rel"]) {
        [religion setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"edu"]) {
        [education setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"fam"]) {
        [family setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"lng"]) {
        [language setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"char"]) {
        [charity setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"gov"]) {
        [government setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"sci"]) {
        [science setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"com"]) {
        [culture setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"film"]) {
        [performance setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"fsh"]) {
        [beauty setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    if ([filtersArray containsObject:@"fsh"]) {
        [fashion setImage: [[UIImage imageNamed: @"fullhearticon.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    }
    

    // Do any additional setup after loading the view.
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
