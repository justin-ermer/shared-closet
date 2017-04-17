//
//  SCConversation.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCConversation.h"

@implementation SCConversation

@dynamic messages;

@dynamic mostRecentMessage;
@dynamic mostRecentTimestamp;

@dynamic participants;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"SCConversation";
}


@end
