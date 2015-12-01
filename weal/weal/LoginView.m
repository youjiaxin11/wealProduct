//
//  LoginView.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginView.h"
#import "StarScreen.h"
#import "ViewController.h"


@implementation LoginView
@synthesize lgnBtn,lgnInput,rgtBtn,pwdInput;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//点击登录按钮
- (IBAction)doClick:(id)sender {
    [self btnClick:@"/mobile/user/login.html"];
   // [self btnClick:@"/memberAction!login.action"];
}

- (void)btnClick:(NSString*)url {
    NSString *param = [NSString stringWithFormat:@"username=%@&password=%@", lgnInput.text, pwdInput.text];
    [self requestTck:url _param:param _callback:^(NSMutableDictionary *map){
        //map中存放服务器返回的信息
        NSLog(@"HERE IS MAP:\n%@",map);
        NSObject *statusObj = [map objectForKey:@"status"];
        int status = [(NSNumber*)statusObj intValue];
        NSString *message = (NSString*)[map objectForKey:@"message"];
        //status表示登录状态结果，1代表成功
        if (status == 1) {//跳转
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            StarScreen *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"StarScreen"];
           // nextPage.user = user;
            [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:nextPage animated:YES completion:nil];
        }else{//提示错误
            [self prompt:message];
        }
    } is_loading:YES is_backup:NO is_solveFail:YES _frequency:0];
    
}

////左滑返回上一页
//- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
//{
//    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
//        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ViewController *backPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
//        [backPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//        [self presentViewController:backPage animated:YES completion:nil];
//    }
//}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"left");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end