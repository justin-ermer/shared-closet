//
//  SCConversation.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <Parse/Parse.h>

@interface SCConversation : PFObject

@property (nonatomic, strong) PFRelation *messages;

//participants relation is useful for querying a user's conversation with another
@property (nonatomic, strong) PFRelation *participants;


- (void)getMostRecentMessage:(PFObjectResultBlock)block;
- (void)getOtherParticipant:(PFObjectResultBlock)block;

@end
