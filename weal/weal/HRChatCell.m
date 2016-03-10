//
//  HRChatCell.m
//  TableViewChatDemo
//
//  Created by Rannie on 13-9-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "HRChatCell.h"
#import "Message.h"

#define RMarginSize 10
#define RBtnX 70
#define RIconSide 50

@implementation HRChatCell

- (void)awakeFromNib
{
    _msgButton.titleLabel.numberOfLines = 0;
    _msgButton.titleLabel.font = [UIFont systemFontOfSize:RChatFontSize];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = _msgButton.frame;
    rect.size.height = self.bounds.size.height - 2*RMarginSize;
    _msgButton.frame = rect;
}

- (void)bindMessage:(Message *)message
{
    UIImage *headerImage;
    UIImage *normalImage;
    UIImage *highlightedImage;
    
    CGRect iconRect = _headerView.frame;
    CGRect btnRect = _msgButton.frame;
    
    UIEdgeInsets insets;
    
    if (message.isMine)
    {
        NSLog(@"me");
        headerImage = [UIImage imageNamed:@"chatMe"];
        normalImage = [UIImage imageNamed:@"mychat_normal"];
        highlightedImage = [UIImage imageNamed:@"mychat_focused"];
        iconRect.origin.x = RMarginSize;
        btnRect.origin.x = RBtnX;        
        insets = UIEdgeInsetsMake(0, 30, 0, 30);
    }
    else
    {
        NSLog(@"other");
        headerImage = [UIImage imageNamed:@"chatOther"];
        normalImage = [UIImage imageNamed:@"other_normal"];
        highlightedImage = [UIImage imageNamed:@"other_focused"];
        
       // iconRect.origin.x = self.bounds.size.width - RMarginSize - RIconSide;
        iconRect.origin.x = RMarginSize + 705;
     //   btnRect.origin.x = self.bounds.size.width - iconRect.origin.x - RMarginSize;
        btnRect.origin.x = RBtnX + 325;
        
        insets = UIEdgeInsetsMake(0, 30, 0, 30);
    }
    _headerView.frame = iconRect;
    _headerView.image = headerImage;
    _headerView.backgroundColor = [UIColor clearColor];
    
    normalImage = [normalImage stretchableImageWithLeftCapWidth:normalImage.size.width*0.5 topCapHeight:normalImage.size.height*0.6];
    highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:highlightedImage.size.width*0.5 topCapHeight:highlightedImage.size.height*0.6];
    
    [_msgButton setContentEdgeInsets:insets];
    _msgButton.frame = btnRect;
    [_msgButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_msgButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [_msgButton setBackgroundColor:[UIColor clearColor]];
    [_msgButton setTitle:message.msg forState:UIControlStateNormal];
}

@end
