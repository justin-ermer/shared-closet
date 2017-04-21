//
//  SCSignUpViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/17/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCSignUpViewController.h"
#import <Parse/Parse.h>
#import "SCUser.h"
#import "UIViewController+SCViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface SCSignUpViewController ()

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;

@end

@implementation SCSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction) didTapCreate
{
    SCUser *user = [SCUser user];
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    user.email = self.emailTextField.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self showAlertWithTitle:@"Sign Up Error" message:[error userInfo][@"error"]];
        }
    }];
}

- (IBAction)didTapClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
