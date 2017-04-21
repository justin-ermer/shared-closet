//
//  SCMyArticlesViewController.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/2/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCMyArticlesViewController.h"
#import "SCCreateArticleViewController.h"

@interface SCMyArticlesViewController ()

@end

@implementation SCMyArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"My Closet"];

    UIBarButtonItem *addArticleButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Article" style:UIBarButtonItemStyleDone target:self action:@selector(addArticlePressed)];
    self.navigationItem.rightBarButtonItem = addArticleButton;
}

- (void) addArticlePressed
{
    [self performSegueWithIdentifier:NSStringFromClass([SCCreateArticleViewController class]) sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
