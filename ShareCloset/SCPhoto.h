//
//  SCPhoto.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/8/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <Parse/Parse.h>

@interface SCPhoto : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, strong) PFFile *photoFile;

@end
