//
//  SCMessagesViewController.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/29/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessagesViewController.h>
@class SCConversation;
@class SCUser;

@interface SCMessagesViewController : JSQMessagesViewController

@property (nonatomic, strong) SCConversation *conversation;
@property (nonatomic, strong) SCUser *recipientUser;
@end
