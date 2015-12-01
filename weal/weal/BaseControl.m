//
//  BaseControl.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseControl.h"
#import "WebUtil.h"


@implementation BaseControl

@synthesize fromControl, fromMap,leftSwipeGestureRecognizer,rightSwipeGestureRecognizer;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //以下为设置页面左滑和右滑手势
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}



#pragma mark 请求TCK服务器
#pragma _partUrl 接口路径，只需要后面一截
#pragma _param 参数，多个参数用&隔开
#pragma _callback 回调函数的block
#pragma is_loading 如果为yes就表示要开启一个UIActivityIndicatorView
#pragma is_backup 是否需要备份数据(一般查询的数据需要备份，提交的数据不需要)
#pragma is_solveFail 调用接口失败时，是否内部处理错误
#pragma _frequency 调用接口的频率(单位：秒)，及时调接口，就传入0
- (void)requestTck:(NSString*)_partUrl _param:(NSString*)_param _callback:(ResponseCallback)_callback is_loading:(BOOL)is_loading is_backup:(BOOL)is_backup is_solveFail:(BOOL)is_solveFail _frequency:(int)_frequency {
    WebUtil *util = [[WebUtil alloc] initWithTck:_partUrl _param:_param _control:self];
    [util requestTck:_callback is_loading:is_loading is_backup:is_backup is_solveFail:is_solveFail _frequency:_frequency];
}

#pragma mark 在底部弹出一个黑色的提示条
- (void)prompt:(NSString*)msg {
    [self.view endEditing:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

//左滑和右滑的实现
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"left");
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right");
    }
}


@end