//
//  SCArticleTableViewCell.h
//  ShareCloset
//
//  Created by Justin Ermer on 4/17/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCArticle;

@interface SCArticleTableViewCell : UITableViewCell

- (void)configureWithArticle:(SCArticle*)article;

@end
