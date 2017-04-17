//
//  SCMessage.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCMessage.h"

@implementation SCMessage

@dynamic message;

@dynamic timestamp;

@dynamic sender;
@dynamic recipient;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"SCMessage";
}


@end
