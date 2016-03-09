//
//  Vhelp.m
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vhelp.h"
#import "Message.h"
#import "HRChatCell.h"

@interface Vhelp () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_msgList;
}

@end

static NSString * const RCellIdentifier = @"HRChatCell";

@implementation Vhelp

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    self.title = @"同事";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UINib *chatNib = [UINib nibWithNibName:@"HRChatCell" bundle:[NSBundle bundleForClass:[HRChatCell class]]];
  
    [self.tableView registerNib:chatNib forCellReuseIdentifier:RCellIdentifier];
   // [self.tableView];
}

- (void)loadData
{
    const NSString *RMsgKey = @"msg";
    const NSString *RMineKey = @"ismine";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
    if (!dataArray)
    {
        NSLog(@"读取文件失败");
        return;
    }
    
    _msgList = [NSMutableArray arrayWithCapacity:dataArray.count];
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        Message *message = [[Message alloc] init];
        message.msg = dict[RMsgKey];
        message.mine = [dict[RMineKey] boolValue];
        [_msgList addObject:message];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _msgList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *msg = _msgList[indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:RChatFontSize];
    CGFloat height = [msg.msg sizeWithFont:font constrainedToSize:CGSizeMake(150, 10000)].height;
    CGFloat lineHeight = [font lineHeight];
    
    return RCellHeight + height - lineHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HRChatCell *cell = [tableView dequeueReusableCellWithIdentifier:RCellIdentifier];
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