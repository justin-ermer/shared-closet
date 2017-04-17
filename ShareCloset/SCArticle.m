//
//  SCArticle.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCArticle.h"

@implementation SCArticle

@dynamic articleTitle;
//@dynamic articleDescription;
//@dynamic image;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"SCArticle";
}

@end
