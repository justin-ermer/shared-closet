//
//  SCConversation.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCConversation.h"
#import "SCMessage.h"
#import "SCUser.h"

@implementation SCConversation

@dynamic messages;
@dynamic participants;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"SCConversation";
}

- (void)getMostRecentMessage:(PFObjectResultBlock)block
{
    PFQuery *mostRecentQuery = [self.messages query];
    [mostRecentQuery includeKey:@"sender"];
    [mostRecentQuery includeKey:@"recipient"];

    [mostRecentQuery orderBySortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO]];
    
    [mostRecentQuery getFirstObjectInBackgroundWithBlock:block];
}

- (void)getOtherParticipant:(PFObjectResultBlock)block
{
    PFQuery *mostRecentQuery = [self.participants query];
    
    [mostRecentQuery whereKey:@"objectId" notEqualTo:[SCUser currentUser].objectId];
    [mostRecentQuery getFirstObjectInBackgroundWithBlock:block];
}

+ (void)getConversationWithUser:(SCUser*)otherUser withBlock:(PFObjectResultBlock)block
{
    PFQuery *convoQuery = [SCConversation query];
    
    [convoQuery whereKey:@"participants" containedIn:@[[SCUser currentUser], otherUser]];
    [convoQuery getFirstObjectInBackgroundWithBlock:block];

}

- (void)getMessagesWithBlock:(PFArrayResultBlock)block
{
    PFQuery *messagesQuery = [self.messages query];
    
    [messagesQuery includeKeys:@[@"recipient", @"sender"]];
    [messagesQuery findObjectsInBackgroundWithBlock:block];
}

@end
