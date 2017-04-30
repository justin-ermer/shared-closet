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

    [mostRecentQuery whereKey:@"recipient" equalTo:[SCUser currentUser]];
    [mostRecentQuery orderBySortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO]];
    
    [mostRecentQuery getFirstObjectInBackgroundWithBlock:block];
}

- (void)getOtherParticipant:(PFObjectResultBlock)block
{
    PFQuery *mostRecentQuery = [self.participants query];
    
    [mostRecentQuery whereKey:@"objectId" notEqualTo:[SCUser currentUser].objectId];
    [mostRecentQuery getFirstObjectInBackgroundWithBlock:block];
   
}

@end
