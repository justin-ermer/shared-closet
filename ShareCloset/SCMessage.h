//
//  SCMessage.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <Parse/Parse.h>
#import "SCUser.h"
#import "SCConversation.h"
#import <JSQMessagesViewController/JSQMessageData.h>

@interface SCMessage : PFObject <JSQMessageData>

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, strong) NSDate *timestamp;

@property (nonatomic, strong) NSString *messageText;

@property (nonatomic, strong) NSNumber *isRead;

@property (nonatomic, strong) SCUser *sender;
@property (nonatomic, strong) SCUser *recipient;

+ (NSString *)parseClassName;

+ (void)createMessage:(NSString*)messageString toUser:(SCUser*)toUser withConversation:(SCConversation*)conversation  resultBlock:(nullable void (^)(SCMessage * _Nullable newMessage, SCConversation * _Nullable newConversation, NSError * _Nullable error))block;

NS_ASSUME_NONNULL_END

@end
