//
//  SCConversationTableViewCell.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@class SCConversation;

@interface SCConversationTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView *isReadView;
@property (nonatomic, weak) IBOutlet PFImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *previewLabel;
@property (nonatomic, weak) IBOutlet UILabel *timestampLabel;

- (void)configureWithConversation:(SCConversation*)conversation;

@end
