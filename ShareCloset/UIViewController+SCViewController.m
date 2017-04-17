//
//  UIViewController+SCViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/16/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "UIViewController+SCViewController.h"

@implementation UIViewController (SCViewController)

- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
