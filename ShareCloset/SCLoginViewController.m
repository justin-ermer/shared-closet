//
//  SCLoginViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/18/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCLoginViewController.h"
#import "SCUser.h"
#import "UIViewController+SCViewController.h"
#import "SCSignUpViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface SCLoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@end

@implementation SCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapLogin:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [SCUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error)
     {
         if (!error)
         {
             [SCUser becomeInBackground:user.sessionToken block:^(PFUser *user, NSError *error)
              {
                  if (!error)
                  {
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                       [self dismissViewControllerAnimated:YES completion:nil];
                  } else {
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      [self showAlertWithTitle:@"Log In Error" message:[error userInfo][@"error"]];
                  }
              }];
         } else {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             [self showAlertWithTitle:@"Log In Error" message:[error userInfo][@"error"]];
         }
     }];
}


@end
