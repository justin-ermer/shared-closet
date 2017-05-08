//
//  SCSearchViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCSearchViewController.h"
#import "SCArticleTableViewCell.h"
#import "SCArticle.h"
#import "SCUser.h"
#import "SCArticleDetailViewController.h"

@interface SCSearchViewController () 

@end

static CGFloat DefaultRowHeight = 80.0f;

@implementation SCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"Search"];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SCArticleTableViewCell class]) bundle: nil]
         forCellReuseIdentifier:NSStringFromClass([SCArticleTableViewCell class])];
    
    UIRefreshControl *pullToRefresh = [[UIRefreshControl alloc] init];
    [pullToRefresh addTarget:self
                      action:@selector(updateArticles)
            forControlEvents:UIControlEventValueChanged];
    
    [self.tableView setRefreshControl:pullToRefresh];
    
    [self updateArticles];
}

- (void)updateArticles
{
    PFQuery *query = [SCArticle query];
    [query whereKeyExists:@"owner"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.articles = objects;
            [self.tableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [self.tableView.refreshControl endRefreshing];
    }];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SCArticleTableViewCell class])];
    
    [cell configureWithArticle:[self.articles objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DefaultRowHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:NSStringFromClass([SCArticleDetailViewController class]) sender:[self.articles objectAtIndex:indexPath.row]];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] isKindOfClass:[SCArticleDetailViewController class]])
    {
        SCArticleDetailViewController *detailVC = (SCArticleDetailViewController*)[segue destinationViewController];
        [detailVC setArticle:sender];
    }

}


@end
