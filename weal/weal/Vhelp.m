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
@synthesize textView,sendBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _msgList = [NSMutableArray arrayWithCapacity:1];
    Message *message = [[Message alloc] init];
    message.msg = @"What can I do for you?";
    message.mine = YES;
    [_msgList addObject:message];

    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UINib *chatNib = [UINib nibWithNibName:@"HRChatCell" bundle:[NSBundle bundleForClass:[HRChatCell class]]];
  
    [self.tableView registerNib:chatNib forCellReuseIdentifier:RCellIdentifier];

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

- (IBAction)sendBtnAction:(id)sender {
    NSString* chatInput = textView.text;
    if (chatInput == nil || [chatInput isEqualToString:@""]) {
        [self prompt:@"输入为空"];
    }else{
        
        //测试用例
        Message *message1 = [[Message alloc] init];
        message1.msg = chatInput;
        message1.mine = NO;
        [_msgList addObject:message1];
        
        Message *message2 = [[Message alloc] init];
        message2.msg = @"I'm from the UK.";
        message2.mine = YES;
        [_msgList addObject:message2];
     
        [self.tableView reloadData];
        [textView setText:@""];
        
//        NSString *param = [NSString stringWithFormat:@"userName=%@", chatInput];
//        
//        [self requestTck:@"mobile/ios/user/login.html" _param:param _callback:^(NSMutableDictionary *map){
//            //map中存放服务器返回的信息
//            NSLog(@"HERE IS MAP:\n%@",map);
//            NSObject *statusObj = [map objectForKey:@"status"];
//            int status = [(NSNumber*)statusObj intValue];
//            NSString *message = (NSString*)[map objectForKey:@"message"];
//            //status表示登录状态结果，1代表成功
//            if (status == 1) {
//                NSMutableDictionary *result = [map objectForKey:@"result"];
//                NSMutableDictionary *data = [[result objectForKey:@"data"] lastObject];
//                NSLog(@"data\n%@",data);
//                
//            }else{
//                //提示错误
//                [self prompt:message];
//            }
//        } is_loading:YES is_backup:NO is_solveFail:YES _frequency:0];
    }
}



//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end