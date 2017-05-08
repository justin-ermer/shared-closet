//
//  SCConversationTableViewCell.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCConversationTableViewCell.h"
#import "SCConversation.h"
#import "SCUser.h"
#import "SCMessage.h"

@implementation SCConversationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureWithConversation:(SCConversation*)conversation
{
    [conversation getMostRecentMessage:^(PFObject * _Nullable object, NSError * _Nullable error) {
        SCMessage *mostRecentMessage = (SCMessage*)object;
        
        self.isReadView.hidden = mostRecentMessage.isRead.boolValue;
        
        [mostRecentMessage.sender fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            [self.avatarImageView setFile:mostRecentMessage.sender.profileImage];
            [self.avatarImageView loadInBackground];
        }];
        
        [self.nameLabel setText:mostRecentMessage.sender.name];
        [self.timestampLabel setText:mostRecentMessage.timestamp.description];
        [self.previewLabel setText:mostRecentMessage.messageText];
    }];
}

@end
