//
//  SCConversationsViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/1/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCConversationsViewController.h"
#import "SCConversation.h"
#import "SCUser.h"
#import "UIViewController+SCViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "SCConversationTableViewCell.h"
#import "SCMessagesViewController.h"

@interface SCConversationsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *conversations;

@end

@implementation SCConversationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"Chats"];

    UIRefreshControl *pullToRefresh = [[UIRefreshControl alloc] init];
    [pullToRefresh addTarget:self
                      action:@selector(updateConversations)
            forControlEvents:UIControlEventValueChanged];
    
    [self.tableView setRefreshControl:pullToRefresh];

}

- (void)updateConversations
{
    PFQuery *query = [SCConversation query];
    [query whereKey:@"sender" equalTo:[SCUser currentUser]];
    [query whereKey:@"recipient" equalTo:[SCUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [self.tableView.refreshControl endRefreshing];

        if(!error)
        {
            self.conversations = objects;
            [self.tableView reloadData];
        }
        else
        {
            [self showAlertWithTitle:@"Error" message:@"There was an error retrieving conversations."];
        }
    }];
}

#pragma - mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue destinationViewController] isKindOfClass:[SCMessagesViewController class]])
    {
        SCMessagesViewController *messagesVC = (SCMessagesViewController*)[segue destinationViewController];
        messagesVC.conversation = sender;
        [messagesVC.conversation getOtherParticipant:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if(object && [object isKindOfClass:[SCUser class]] && !error) messagesVC.recipientUser = (SCUser*)object;
        }];
    }
}

#pragma - mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:NSStringFromClass([SCMessagesViewController class]) sender:[self.conversations objectAtIndex:indexPath.row]];
}

#pragma - mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.conversations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SCConversationTableViewCell class])];
    
    [cell configureWithConversation:[self.conversations objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

@end
