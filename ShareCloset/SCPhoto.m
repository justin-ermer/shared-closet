//
//  SCPhoto.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/8/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCPhoto.h"
#import <Parse/Parse.h>

@implementation SCPhoto

@dynamic photoFile;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"SCPhoto";
}

@end
