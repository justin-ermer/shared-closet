//
//  SCLandingViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/16/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCLandingViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "SCTabBarController.h"

@interface SCLandingViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation SCLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue destinationViewController] isKindOfClass:[PFLogInViewController class]])
    {
        PFLogInViewController *loginVC = [segue destinationViewController];
        [loginVC setDelegate:self];
        [[loginVC signUpController] setDelegate:self];
        [[loginVC signUpController] setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    }
}

#pragma mark - PFLogInViewControllerDelegate

 - (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:NSStringFromClass([SCTabBarController class]) sender:self];
    }];
}
 
#pragma mark - PFSignUpViewControllerDelegate

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [signUpController dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
