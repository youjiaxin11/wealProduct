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

static User *user;

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_fromRegister){
        lgnInput.text = _userNameFromRegister;
        pwdInput.text = _passwordFromRegister;
    }
    lgnBtn.backgroundColor = [UIColor clearColor];
    lgnBtn.enabled = true;
}

//点击登录按钮
- (IBAction)doClick:(id)sender {
    //判断是否可以发给后台
    if (lgnInput.text == nil||pwdInput.text == nil||[lgnInput.text isEqualToString:@""]||[pwdInput.text isEqualToString:@""]) {
        NSString *message = @"请填写全部信息";
        [self prompt:message];
    }else{
        [self btnClick:@"mobile/ios/user/login.html"];
    }
//    //跳转
//    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    StarScreen *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"StarScreen"];
//    // nextPage.user = user;
//    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//    [self presentViewController:nextPage animated:YES completion:nil];
    
}

- (void)btnClick:(NSString*)url {
    
    lgnBtn.backgroundColor = [UIColor grayColor];
    lgnBtn.enabled = false;
    NSString *param = [NSString stringWithFormat:@"userName=%@&password=%@", lgnInput.text, pwdInput.text];
    [self requestTck:url _param:param _callback:^(NSMutableDictionary *map){
        //map中存放服务器返回的信息
        NSLog(@"HERE IS MAP:\n%@",map);
        NSObject *statusObj = [map objectForKey:@"status"];
        int status = [(NSNumber*)statusObj intValue];
        NSString *message = (NSString*)[map objectForKey:@"message"];
        //status表示登录状态结果，1代表成功
        if (status == 1) {
            lgnBtn.backgroundColor = [UIColor clearColor];
            lgnBtn.enabled = true;
            
            NSMutableDictionary *result = [map objectForKey:@"result"];
            NSMutableDictionary *data = [[result objectForKey:@"data"] lastObject];
            NSLog(@"data\n%@",data);

            //接收user全部信息
            User *user = [[User alloc]init];
           // user = [self getUser:data];
            user.userId = (NSString*)[data objectForKey:@"userId"];
            user.loginName = (NSString*)[data objectForKey:@"userName"];
            user.password = (NSString*)[data objectForKey:@"password"];
            user.realName = (NSString*)[data objectForKey:@"realName"];
            user.sex = [(NSNumber*)[data objectForKey:@"sex"] intValue];
            user.role = [(NSNumber*)[data objectForKey:@"role"] intValue];
            user.school = [(NSNumber*)[data objectForKey:@"school"] intValue];
            user.grade = [(NSNumber*)[data objectForKey:@"grade"] intValue];
            user.classNum = [(NSNumber*)[data objectForKey:@"classNumber"] intValue];
            user.golden = [(NSNumber*)[data objectForKey:@"golden"] intValue];
            user.medal = [(NSNumber*)[data objectForKey:@"medal"] intValue];
            user.rank = [(NSNumber*)[data objectForKey:@"rank"] intValue];
            user.loginTimes = [(NSNumber*)[data objectForKey:@"loginTimes"] intValue];
            user.wordCount = [(NSNumber*)[data objectForKey:@"wordCount"] intValue];
            user.workCount = [(NSNumber*)[data objectForKey:@"workCount"] intValue];
            user.birthYear = [(NSNumber*)[data objectForKey:@"birthYear"] intValue];
            user.createTime = (NSString*)[data objectForKey:@"createTime"];
            
            NSLog(@"HERE IS USER:\n%@",user);
            
            //跳转
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            StarScreen *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"StarScreen"];
            nextPage.user = user;
            [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:nextPage animated:YES completion:nil];
        }else{
            lgnBtn.backgroundColor = [UIColor clearColor];
            lgnBtn.enabled = true;
            //提示错误
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
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];    }
}


@end