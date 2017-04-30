//
//  SCMessage.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCMessage.h"
#import "SCConversation.h"
#import "SCUser.h"

@implementation SCMessage

@dynamic messageText;

@dynamic timestamp;
@dynamic isRead;

@dynamic sender;
@dynamic recipient;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"SCMessage";
}

+ (void)createMessage:(NSString*)messageString toUser:(SCUser*)toUser withConversation:(SCConversation*)conversation resultBlock:(nullable void (^)(SCMessage * _Nullable savedMessage, SCConversation * _Nullable savedConversation, NSError * _Nullable error))block
{
    SCMessage *newMessage = [SCMessage object];
    [newMessage setMessageText:messageString];
    [newMessage setTimestamp:[NSDate date]];
    [newMessage setRecipient:toUser];
    [newMessage setSender:[SCUser currentUser]];
    
    [newMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded)
        {
            SCConversation *savingConversation = conversation;
            if(!conversation)
            {
                savingConversation = [SCConversation object];
                [[savingConversation participants] addObject:toUser];
                [[savingConversation participants] addObject:[SCUser currentUser]];
            }
            
            [[savingConversation messages] addObject:newMessage];
            [savingConversation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if(succeeded)
                {
                    block(newMessage, savingConversation, error);
                }
                else
                {
                    [newMessage deleteInBackground];
                    block(nil, nil, error);
                }
            }];
        }
        else
        {
            [newMessage deleteInBackground];
            block(nil, nil, error);
        }
        
    }];
    
}

#pragma - mark JSQMessageData

- (NSString *)senderId
{
    return self.sender.objectId;
}

- (NSString *)senderDisplayName
{
    return self.sender.name;
}

- (NSDate *)date
{
    return self.timestamp;
}

- (BOOL)isMediaMessage
{
    return NO;
}

- (NSUInteger)messageHash
{
    return self.messageText.hash;
}

- (NSString *)text
{
    return self.messageText;
}

@end
