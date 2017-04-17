//
//  SCCreateArticleViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCCreateArticleViewController.h"
#import "UIViewController+SCPhotoAlert.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Parse/Parse.h>
#import "SCArticle.h"
#import "SCPhoto.h"
#import "UIViewController+SCViewController.h"

@interface SCCreateArticleViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UITextField *articleTitle;
@property (nonatomic, weak) IBOutlet UITextView *articleDescription;



@end

@implementation SCCreateArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:UIBarButtonItemStyleDone target:self action:@selector(didTapConfirm:)]];
}

- (IBAction)didTapPhoto:(id)sender
{
    [self showPhotoAlertForController:self];
}

- (IBAction)didTapConfirm:(id)sender
{
    [[[self navigationItem] rightBarButtonItem] setEnabled:NO];
    
    SCArticle *article = [SCArticle object];
    article.articleTitle = self.articleTitle.text;
    article.articleDescription = self.articleDescription.text;
    
    NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
    NSString *imageName = [NSString stringWithFormat:@"%d%@", (int)[[NSDate date] timeIntervalSince1970], @"image.png"];
    PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
    
    SCPhoto *photo = [SCPhoto object];
    [photo setPhotoFile:imageFile];
    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (!succeeded) {
            [[[self navigationItem] rightBarButtonItem] setEnabled:YES];

            [self showAlertWithTitle:@"Error" message:@"An error has occured trying to upload your image. Please try again."];
        }
        
        [article setImage:photo];
        
        [article saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            if (!succeeded) {
                [[[self navigationItem] rightBarButtonItem] setEnabled:YES];
                
                [self showAlertWithTitle:@"Error" message:@"An error has occured trying to upload your article. Please try again."];
            }
            else
            {
                [self showAlertWithTitle:nil message:@"You have successfully added your new clothing item!" ];
            }
        }];
    }];
    
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:image];
    
    

    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [[SAWebService sharedInstance] uploadImage:image forUserId:self.user.userId withSuccess:^(id result) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [self refreshPictures];
//    } andFailure:^(NSError *error) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [self handleRequestError:error];
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
