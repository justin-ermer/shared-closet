//
//  SCMessagesViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/29/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCMessagesViewController.h"
#import "SCConversation.h"
#import "SCUser.h"
#import "SCMessage.h"
#import "SCPhoto.h"
#import <JSQMessagesViewController/JSQMessages.h>
#import "UIColor+JSQMessages.h"
#import <JSQMessagesAvatarImageFactory.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface SCMessagesViewController () <JSQMessagesCollectionViewDataSource, JSQMessagesCollectionViewCellDelegate>

@property (nonatomic, strong) NSArray *messages;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;
@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;

@property (strong, nonatomic) JSQMessagesAvatarImage *userAvatarImage;
@property (strong, nonatomic) JSQMessagesAvatarImage *recipientAvatarImage;

@end

@implementation SCMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    
    self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    
    self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
    
    self.userAvatarImage = [[JSQMessagesAvatarImage alloc]
                            initWithAvatarImage:[UIImage imageWithData:[[[SCUser currentUser] profileImage] getDataInBackground].result]
                            highlightedImage:[UIImage imageWithData:[[[SCUser currentUser] profileImage] getDataInBackground].result]
                            placeholderImage:[UIImage imageNamed:@"logo"]];


    self.recipientAvatarImage = [[JSQMessagesAvatarImage alloc]
                            initWithAvatarImage:[UIImage imageWithData:[[self.recipientUser profileImage] getDataInBackground].result]
                            highlightedImage:[UIImage imageWithData:[[[SCUser currentUser] profileImage] getDataInBackground].result]
                            placeholderImage:[UIImage imageNamed:@"logo"]];
}


#pragma mark - JSQMessagesCollectionViewDataSource

- (NSString *)senderDisplayName
{
    return [[SCUser currentUser] name];
}

- (NSString *)senderId
{
    return [[SCUser currentUser] objectId];
}


- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.row];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SCMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.outgoingBubbleImageData;
    }
    
    return self.incomingBubbleImageData;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SCMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId])
    {
        return self.userAvatarImage;
    }
    else
    {
        return self.recipientAvatarImage;
    }
}


#pragma - mark JSQMessagesCollectionViewCellDelegate

- (void)messagesCollectionViewCellDidTapAvatar:(JSQMessagesCollectionViewCell *)cell
{
    //will want to go to user's profile eventually
}

- (void)messagesCollectionViewCellDidTapMessageBubble:(JSQMessagesCollectionViewCell *)cell
{
}

- (void)messagesCollectionViewCellDidTapCell:(JSQMessagesCollectionViewCell *)cell atPosition:(CGPoint)position
{
}

- (void)messagesCollectionViewCell:(JSQMessagesCollectionViewCell *)cell didPerformAction:(SEL)action withSender:(id)sender
{
}

- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [SCMessage createMessage:text toUser:self.recipientUser withConversation:self.conversation
                 resultBlock:^(SCMessage * _Nullable newMessage, SCConversation * _Nullable newConversation, NSError * _Nullable error) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if(newMessage)
                     {
                         self.messages = [self.messages arrayByAddingObject:newMessage];
                         self.conversation = newConversation;
                         [[self collectionView] reloadData];
                     }
                     else
                     {
                         //didnt go through
                     }
                 }
    ];
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
