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
#import "SCMessagesViewController.h"
#import "SCConversation.h"
#import "SCMessage.h"
#import <ParseUI/ParseUI.h>

@interface SCArticleDetailViewController ()

@property (nonatomic, weak) IBOutlet PFImageView *articleImageView;
@property (nonatomic, weak) IBOutlet UILabel *articleDescriptionLabel;

@property (nonatomic, weak) IBOutlet PFImageView *ownerThumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *ownerNameLabel;

@end

@implementation SCArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateViews];
}

- (void)updateViews
{
    [self setTitle:[self.article articleTitle]];
    [self.articleDescriptionLabel setText:[self.article articleDescription]];
    
    [self.articleImageView setFile:[[self.article image] photoFile]];
    [self.articleImageView loadInBackground];

    
    [[self.article owner] fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        [self.ownerNameLabel setText:[self.article.owner name]];
        
        [self.ownerThumbnailImageView setFile:[[self.article owner] profileImage]];
        [self.ownerThumbnailImageView loadInBackground];
    }];
    
}

- (IBAction)didTapContact:(id)sender
{
    [SCConversation getConversationWithUser:self.article.owner
                                  withBlock:^(PFObject * _Nullable convo, NSError * _Nullable error) {
                                      if(convo)
                                      {
                                          [(SCConversation*)convo getMessagesWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                                              [self performSegueWithIdentifier:NSStringFromClass([SCMessagesViewController class]) sender:convo];
                                          }];
                                      }
                                      else
                                      {
                                          [self performSegueWithIdentifier:NSStringFromClass([SCMessagesViewController class]) sender:nil];
                                      }
                                  }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue destinationViewController] isKindOfClass:[SCMessagesViewController class]])
    {
        SCMessagesViewController *messagesVC = (SCMessagesViewController*)[segue destinationViewController];
        
        [messagesVC setRecipientUser:self.article.owner];
        
        if(sender) [messagesVC setConversation:sender];        
    }
    
}


@end
