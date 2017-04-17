//
//  UIViewController+SCPhotoAlert.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "UIViewController+SCPhotoAlert.h"

@implementation UIViewController (SCPhotoAlert)

- (void)showPhotoAlertForController:(UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>*) controller
{
    UIAlertController *photoActionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Take Photo", @"Take Photo")
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *_Nonnull action) {
                                                                [controller takeAPhotoForController:controller];
                                                            }];
    
    UIAlertAction *choosePhotoAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Choose Photo", @"Choose Photo")
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *_Nonnull action) {
                                                                  [controller chooseAPhotoForController:controller];
                                                              }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *_Nonnull action){
                                                             
                                                         }];
    
    [photoActionSheet addAction:takePhotoAction];
    [photoActionSheet addAction:choosePhotoAction];
    [photoActionSheet addAction:cancelAction];
    
    [controller presentViewController:photoActionSheet animated:YES completion:nil];
}

- (void)takeAPhotoForController:(UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>*) controller
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    picker.delegate = controller;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)chooseAPhotoForController:(UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>*) controller
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = controller;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerDelegate

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//    image = [info objectForKey:UIImagePickerControllerEditedImage];
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [[SAWebService sharedInstance] uploadImage:image forUserId:self.user.userId withSuccess:^(id result) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [self refreshPictures];
//    } andFailure:^(NSError *error) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [self handleRequestError:error];
//    }];
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

@end
