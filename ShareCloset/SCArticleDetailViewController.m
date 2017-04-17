//
//  SCArticleDetailViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCArticleDetailViewController.h"
#import "SCArticle.h"
#import "UIViewController+SCViewController.h"

@interface SCArticleDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *articleImageView;
@property (nonatomic, weak) IBOutlet UILabel *articleDescriptionLabel;

@property (nonatomic, weak) IBOutlet UIImageView *ownerThumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *ownerNameLabel;

@end

@implementation SCArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)updateViews
{
    [self setTitle:[self.article articleTitle]];
    [self.articleDescriptionLabel setText:[self.article articleDescription]];
    
    [[[self.article image] photoFile] getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            [self.articleImageView setImage:[UIImage imageWithData:imageData]];
        }
        else
        {
            [self showAlertWithTitle:@"Error" message:@"Error downloading image."];
        }
    }];

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
