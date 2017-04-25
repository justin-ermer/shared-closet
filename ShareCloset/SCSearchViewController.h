//
//  SCSearchViewController.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
