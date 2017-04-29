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
#import <ParseUI/ParseUI.h>
#import "SCArticle.h"
#import "SCPhoto.h"
#import "UIViewController+SCViewController.h"
#import "SCUser.h"
#import <CoreGraphics/CoreGraphics.h>

@interface SCCreateArticleViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (nonatomic, weak) IBOutlet PFImageView *articleImageView;
@property (nonatomic, weak) IBOutlet UITextView *articleTitleTextView;
@property (nonatomic, weak) IBOutlet UITextView *articleDescriptionTextView;

@property (nonatomic, weak) IBOutlet UIButton *articleImageButton;

@property (nonatomic, weak) IBOutlet UILabel *articleTitlePlaceholderLabel;
@property (nonatomic, weak) IBOutlet UILabel *articleDescriptionPlaceholderLabel;

@property (nonatomic, assign) BOOL didUpdateImage;

@end

static NSString *TitlePlaceholder = @"Title";
static NSString *DescriptionPlaceholder = @"Description";

@implementation SCCreateArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.didUpdateImage = NO;
    
    self.articleImageButton.layer.cornerRadius = 5.0f;
    self.articleImageButton.layer.borderColor = [UIColor colorWithWhite:0.5f alpha:0.5f].CGColor;
    self.articleImageButton.layer.borderWidth = 1.0f;
    
    [self.articleTitlePlaceholderLabel setText:TitlePlaceholder];
    [self.articleDescriptionPlaceholderLabel setText:DescriptionPlaceholder];
    
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:UIBarButtonItemStyleDone target:self action:@selector(didTapConfirm:)]];
    
    [self updateUI];
}

- (void)updateUI
{
    if(self.article)
    {
        [self.article fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            [self.articleTitleTextView setText:self.article.articleTitle];
            [self.articleDescriptionTextView setText:self.article.articleDescription];
            
            [[self.article image] fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
                [self.articleImageView setFile:[[self.article image] photoFile]];
                [self.articleImageView loadInBackground];
            }];
        }];
    }
    
    [self.articleTitlePlaceholderLabel setHidden:![self.articleTitleTextView.text isEqualToString:@""]];
    [self.articleDescriptionPlaceholderLabel setHidden:![self.articleDescriptionTextView.text isEqualToString:@""]];
}

- (IBAction)didTapPhoto:(id)sender
{
    [self showPhotoAlertForController:self];
}

//better way to handle consecutive parse object saves?
//do saves propagate among pfrelations? ie create local pffile, scphoto, set on
//a scarticle, and just call save on the article?
- (IBAction)didTapConfirm:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[[self navigationItem] rightBarButtonItem] setEnabled:NO];
    
    if(self.article)
    {
        self.article.articleTitle = self.articleTitleTextView.text;
        self.article.articleDescription = self.articleDescriptionTextView.text;
        
        if(self.didUpdateImage)
        {
            [self savePhotoWithBlock:^(BOOL succeeded, SCPhoto *photo, NSError * _Nullable error) {
                if(succeeded)
                {
                    [self.article setImage:photo];

                    [self.article saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
                     {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [self.navigationController popViewControllerAnimated:YES];
                     }];
                }
                else
                {
                    [[[self navigationItem] rightBarButtonItem] setEnabled:YES];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                    [self showAlertWithTitle:@"Error" message:@"An error has occured trying to update your article. Please try again."];
                }
            }];
        }
        else
        {
            [self.article saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }
    else
    {
        SCArticle *article = [SCArticle object];
        article.articleTitle = self.articleTitleTextView.text;
        article.articleDescription = self.articleDescriptionTextView.text;
        article.owner = [SCUser currentUser];
        
        [self savePhotoWithBlock:^(BOOL succeeded, SCPhoto *photo, NSError * _Nullable error) {
            if(!succeeded)
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [[[self navigationItem] rightBarButtonItem] setEnabled:YES];
                [self showAlertWithTitle:@"Error" message:@"An error has occured trying to upload your article. Please try again."];
                
            }
            else
            {
                [article setImage:photo];
                
                [article saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    
                    if (!succeeded) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [[[self navigationItem] rightBarButtonItem] setEnabled:YES];
                        [self showAlertWithTitle:@"Error" message:@"An error has occured trying to upload your article. Please try again."];
                    }
                    else
                    {
                        [[[SCUser currentUser] articles] addObject:article];
                        [[SCUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            
                            if (succeeded) {
                                [self dismissViewControllerAnimated:YES completion:nil];
                            } else {
                                [photo deleteInBackground];
                                [article deleteInBackground];
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                [[[self navigationItem] rightBarButtonItem] setEnabled:YES];
                                [self showAlertWithTitle:@"Error" message:@"An error has occured trying to upload your article. Please try again."];
                            }
                        }];
                    }
                }];
            }
        }];
    }
}

- (void)savePhotoWithBlock:(void (^)(BOOL succeeded, SCPhoto *photo, NSError *_Nullable error))block
{
    NSData *imageData = UIImagePNGRepresentation(self.articleImageView.image);
    NSString *imageName = [NSString stringWithFormat:@"%d%@", (int)[[NSDate date] timeIntervalSince1970], @"image.png"];
    PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
    
    SCPhoto *photo = [SCPhoto object];
    [photo setPhotoFile:imageFile];
    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!succeeded)
        {
            block(succeeded, nil, error);
        }
        else
        {
            block(succeeded, photo, error);
        }
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.articleImageView setImage:image];
    
    self.didUpdateImage = YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextView 

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(textView == self.articleTitleTextView)
    {
        [self.articleTitlePlaceholderLabel setHidden:![[textView.text stringByReplacingCharactersInRange:range withString:text] isEqualToString:@""]];
    }
    else if(textView == self.articleDescriptionTextView)
    {
        [self.articleDescriptionPlaceholderLabel setHidden:![[textView.text stringByReplacingCharactersInRange:range withString:text] isEqualToString:@""]];
    }
    
    return YES;
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
