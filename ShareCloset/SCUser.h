//
//  SCUser.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <Parse/Parse.h>

@interface SCUser : PFUser

@property (nonatomic, strong) PFFile *profileImage;


@end