//
//  SCConversation.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <Parse/Parse.h>

@interface SCConversation : PFObject

@property (nonatomic, strong) NSArray *messages;

@property (nonatomic, strong) NSString *mostRecentMessage;
@property (nonatomic, strong) NSDate *mostRecentTimestamp;

@property (nonatomic, strong) NSArray *participants;

@end
