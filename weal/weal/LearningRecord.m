//
//  LearningRecord.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LearningRecord.h"
 #import <objc/runtime.h>
@implementation LearningRecord

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 加载页面
//    NSString* urlstr = [root_url stringByAppendingString:@"admin/loginUI.html"];
    
    NSString* urlstr = @"http://172.19.203.216:8080/DataREchart/WChart.jsp";
    NSLog(@"urlstr%@",urlstr);
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url] ;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_webShow loadRequest:request];
    });
//    
    [_nameLbl setText:self.userLearningRecord.loginName];
    [_ageLbl setText:[NSString stringWithFormat:@"%d",self.userLearningRecord.birthYear]];
    [_goldenLbl setText:[NSString stringWithFormat:@"%d",self.userLearningRecord.golden]];
    
}



//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end