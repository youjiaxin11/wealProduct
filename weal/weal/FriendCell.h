//
//  HRChatCell.h
//  TableViewChatDemo
//
//  Created by Rannie on 13-9-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RChatFontSize 24.0f
#define RCellHeight 60

@class Message;
@interface  FriendCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *msgButton;
@property (strong, nonatomic) IBOutlet UIButton *goldenBtn;
- (void)bindMessage:(Message *)message;
@end
