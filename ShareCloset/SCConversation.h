//
//  SCConversation.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <Parse/Parse.h>
@class SCUser;

@interface SCConversation : PFObject <PFSubclassing>

@property (nonatomic, strong, readonly) PFRelation *messages;

//participants relation is useful for querying a user's conversation with another
@property (nonatomic, strong, readonly) PFRelation *participants;


- (void)getMostRecentMessage:(PFObjectResultBlock)block;
- (void)getOtherParticipant:(PFObjectResultBlock)block;
- (void)getMessagesWithBlock:(PFArrayResultBlock)block;

+ (void)getConversationWithUser:(SCUser*)otherUser withBlock:(PFObjectResultBlock)block;

@end
