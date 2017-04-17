//
//  SCArticle.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import "SCPhoto.h"

@interface SCArticle : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, strong) NSString * articleTitle;
@property (nonatomic, strong) NSString * articleDescription;
@property (nonatomic, strong) SCPhoto *image;

@end
