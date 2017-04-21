//
//  SCSettingsTableViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/21/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCSettingsTableViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "SCTabBarController.h"

@interface SCSettingsTableViewController ()

@end

@implementation SCSettingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Settings"];
}

- (IBAction)didTapLogOut:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [((SCTabBarController*)self.tabBarController) checkUserState];
        [self.tabBarController setSelectedIndex:0];
    }];
}

@end
