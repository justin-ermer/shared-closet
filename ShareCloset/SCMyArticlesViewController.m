//
//  SCMyArticlesViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/2/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCMyArticlesViewController.h"
#import "SCCreateArticleViewController.h"
#import <Parse/Parse.h>
#import "SCArticle.h"

//TODO improve derivative behvaior with myclosetvc vs searchvc

@interface SCMyArticlesViewController ()

@property (nonnull, strong) NSNumber *selectedRow;

@end

@implementation SCMyArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"My Closet"];

    UIBarButtonItem *addArticleButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Article" style:UIBarButtonItemStyleDone target:self action:@selector(addArticlePressed)];
    self.navigationItem.rightBarButtonItem = addArticleButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.selectedRow)
    {
        [[self.articles objectAtIndex:self.selectedRow.integerValue] fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.selectedRow.integerValue inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }
}

- (void)updateArticles
{
    PFQuery *query = [SCArticle query];
    [query whereKey:@"owner" equalTo:[SCUser currentUser]];
    
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

- (void) addArticlePressed
{
    [self performSegueWithIdentifier:NSStringFromClass([SCCreateArticleViewController class]) sender:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = @(indexPath.row);
    [self performSegueWithIdentifier:NSStringFromClass([SCCreateArticleViewController class]) sender:[self.articles objectAtIndex:indexPath.row]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue destinationViewController] isKindOfClass:[SCCreateArticleViewController class]])
    {
        [((SCCreateArticleViewController*)[segue destinationViewController]) setArticle:sender];
    }
}

@end
