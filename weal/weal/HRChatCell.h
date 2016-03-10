//
//  HRChatCell.h
//  TableViewChatDemo
//
//  Created by Rannie on 13-9-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RChatFontSize 20.0f
#define RCellHeight 60

@class Message;
@interface HRChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *msgButton;
- (void)bindMessage:(Message *)message;
@end
