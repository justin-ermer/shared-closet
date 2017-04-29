//
//  SCCreateProfileViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCCreateProfileViewController.h"
#import <Parse/Parse.h>
#import "SCUser.h"
#import <ParseUI/ParseUI.h>
#import "UIViewController+SCPhotoAlert.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface SCCreateProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet PFImageView *profileImageView;
@property (nonatomic, weak) IBOutlet UITextField *nameTextfield;

@property (nonatomic, assign) BOOL didUpdateImage;

@end

@implementation SCCreateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(didTapSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    if([SCUser currentUser].name) [self.nameTextfield setText:[SCUser currentUser].name];
    if([SCUser currentUser].profileImage)
    {
        [self.profileImageView setFile:[SCUser currentUser].profileImage];
        [self.profileImageView loadInBackground];
    }
}

- (IBAction)didTapSave:(id)sender
{
    [[SCUser currentUser] setName:self.nameTextfield.text];
    
    if(self.didUpdateImage)
    {
        NSData *imageData = UIImagePNGRepresentation(self.profileImageView.image);
        NSString *imageName = [NSString stringWithFormat:@"%d%@", (int)[[NSDate date] timeIntervalSince1970], @"image.png"];
        PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
        [SCUser currentUser].profileImage = imageFile;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[SCUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (IBAction)didTapPhoto:(id)sender
{
    [self showPhotoAlertForController:self];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.profileImageView setImage:image];
    
    self.didUpdateImage = YES;
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
