//
//  HRChatCell.m
//  TableViewChatDemo
//
//  Created by Rannie on 13-9-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "FriendCell.h"
#import "Friend.h"

#define RMarginSize 10
#define RBtnX 70
#define RIconSide 50

@implementation FriendCell

- (void)awakeFromNib
{
    _msgButton.titleLabel.numberOfLines = 0;
   // _msgButton.titleLabel.font = [UIFont systemFontOfSize:RChatFontSize];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = _msgButton.frame;
    rect.size.height = self.bounds.size.height - 2*RMarginSize;
    _msgButton.frame = rect;
}

- (void)bindMessage:(Friend *)friend
{
    UIImage *headerImage;
    CGRect iconRect = _headerView.frame;
    CGRect btnRect = _msgButton.frame;
    UIEdgeInsets insets;
    headerImage = [UIImage imageNamed:@"chatMe"];
    iconRect.origin.x = RMarginSize;
    btnRect.origin.x = RBtnX;
    insets = UIEdgeInsetsMake(0, 30, 0, 30);

    _headerView.frame = iconRect;
    _headerView.image = headerImage;
    _headerView.backgroundColor = [UIColor clearColor];

    
    [_msgButton setContentEdgeInsets:insets];
    _msgButton.frame = btnRect;

    [_msgButton setBackgroundColor:[UIColor clearColor]];
    [_msgButton setTitle:friend.friendName forState:UIControlStateNormal];
    
    [_goldenBtn setBackgroundColor:[UIColor clearColor]];
    [_goldenBtn setTitle:[NSString stringWithFormat:@"%d",friend.golden] forState:UIControlStateNormal];
}

@end
