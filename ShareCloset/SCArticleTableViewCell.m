//
//  SCArticleTableViewCell.m
//  ShareCloset
//
//  Created by Justin Ermer on 4/17/17.
//  Copyright © 2017 Justin Ermer. All rights reserved.
//

#import "SCArticleTableViewCell.h"
#import "SCArticle.h"
#import <ParseUI/ParseUI.h>
#import "SCPhoto.h"

@interface SCArticleTableViewCell ()

@property (nonatomic, weak) IBOutlet PFImageView *articleImageView;
@property (nonatomic, weak) IBOutlet UILabel *articleTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *articleOwnerNameLabel;

@end

@implementation SCArticleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithArticle:(SCArticle*)article
{
    [article fetchIfNeeded];
    [[article image] fetchIfNeeded];
    
    [self.articleTitleLabel setText:article.articleTitle];
//    [self.articleOwnerNameLabel setText:article.articleDescription];
    
    [self.articleImageView setFile:[[article image] photoFile]];
    [self.articleImageView loadInBackground];
}

@end
