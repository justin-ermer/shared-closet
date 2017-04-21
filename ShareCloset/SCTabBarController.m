//
//  SCTabBarController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/17/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCTabBarController.h"
#import "SCLoginViewController.h"
#import <Parse/Parse.h>

@interface SCTabBarController ()

@end

@implementation SCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self checkUserState];
}

- (void)checkUserState
{
    if([PFUser currentUser] == nil)
    {
        [self performSegueWithIdentifier:NSStringFromClass([SCLoginViewController class]) sender:self];
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
