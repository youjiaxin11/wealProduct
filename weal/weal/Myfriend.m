//
//  Myfriend.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendCell.h"
#import "Message.h"
#import "Myfriend.h"

@interface Myfriend () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_msgList;
}

@end

static NSString * const RCellIdentifier = @"FriendCell";

@implementation Myfriend


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _msgList = [NSMutableArray arrayWithCapacity:6];
//    for (int i=0; i<6; i++) {
//        Friend *friend = [[Friend alloc] init];
//        friend.friendId = i+1;
//        friend.friendName = @"Ming";
//        friend.golden  = 1000;
//        [_msgList addObject:friend];
//
//    }
    Friend *friend = [[Friend alloc] init];
    friend.friendName = @"Ming";
    friend.golden  = 3000;
    [_msgList addObject:friend];
    
    Friend *friend2 = [[Friend alloc] init];
    friend2.friendName = @"Meimei";
    friend2.golden  = 998;
    [_msgList addObject:friend2];
    
    Friend *friend3 = [[Friend alloc] init];
    friend3.friendName = @"Siyu";
    friend3.golden  = 980;
    [_msgList addObject:friend3];
    
    Friend *friend4 = [[Friend alloc] init];
    friend4.friendName = @"Ran";
    friend4.golden  = 870;
    [_msgList addObject:friend4];
    
    Friend *friend5 = [[Friend alloc] init];
    friend5.friendName = @"Kai";
    friend5.golden  = 680;
    [_msgList addObject:friend5];
    
    Friend *friend6 = [[Friend alloc] init];
    friend6.friendName = @"Song";
    friend6.golden  = 340;
    [_msgList addObject:friend6];
    
    
    self.friendsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.friendsTableView.backgroundColor = [UIColor clearColor];
    
    UINib *chatNib = [UINib nibWithNibName:@"FriendCell" bundle:[NSBundle bundleForClass:[FriendCell class]]];
    
    [self.friendsTableView registerNib:chatNib forCellReuseIdentifier:RCellIdentifier];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _msgList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend *fri = _msgList[indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:RChatFontSize];
    CGFloat height = [fri.friendName sizeWithFont:font constrainedToSize:CGSizeMake(150, 10000)].height;
    CGFloat lineHeight = [font lineHeight];
    
    return RCellHeight + height - lineHeight+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:RCellIdentifier];
    [cell bindMessage:_msgList[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end