//
//  UIViewController+SCPhotoAlert.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SCPhotoAlert)

- (void)showPhotoAlertForController:(UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>*) controller;
- (void)takeAPhotoForController:(UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>*) controller;
- (void)chooseAPhotoForController:(UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>*) controller;

@end
