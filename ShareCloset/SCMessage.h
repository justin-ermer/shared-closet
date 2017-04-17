//
//  SCMessage.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <Parse/Parse.h>
#import "SCUser.h"

@interface SCMessage : PFObject

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) NSDate *timestamp;

@property (nonatomic, strong) SCUser *sender;
@property (nonatomic, strong) SCUser *recipient;

@end
