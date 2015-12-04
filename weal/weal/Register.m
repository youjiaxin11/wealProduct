//
//  Register.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Register.h"
#import "BaseControl.h"
#import "LoginView.h"
@implementation Register

//初始化声明的属性
@synthesize loginName,firstPassword,secondPassword,okBtn,sexPicker,gradePicker,sexPickerArray,gradePickerArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //选择器初始化
    sexPickerArray = @[@"Boy",@"Girl"];
    gradePickerArray = @[@"Grade 1",@"Grade 2",@"Grade 3",@"Grade 4",@"Grade 5",@"Grade 6"];
    
    NSInteger sexRow = [sexPicker selectedRowInComponent:0];
    NSString *sexValue = [sexPickerArray objectAtIndex:sexRow];
    NSInteger gradeRow = [gradePicker selectedRowInComponent:0];
    NSString *gradeValue = [gradePickerArray objectAtIndex:gradeRow];
    NSLog(@"%@",sexValue);
    NSLog(@"%@",gradeValue);
    
}

//点击OK按钮
- (IBAction)doClick:(id)sender {
    
    //命令行输出一下（测试用的）
    NSLog(@"do click!");
    NSInteger sexRow = [sexPicker selectedRowInComponent:0];
    NSString *sexValue = [sexPickerArray objectAtIndex:sexRow];
    NSInteger gradeRow = [gradePicker selectedRowInComponent:0];
    NSString *gradeValue = [gradePickerArray objectAtIndex:gradeRow];
    NSLog(@"%@",sexValue);
    NSLog(@"%@",gradeValue);
    
    //判断是否可以发给后台
    if (loginName.text == nil||firstPassword == nil||secondPassword == nil||[firstPassword.text isEqualToString:@""]||[secondPassword.text isEqualToString:@""]||[loginName.text isEqualToString:@""]) {
        NSString *message = @"Please fill in all of the columns!";
        [self registerPrompt:message];
    }else if(loginName.text.length < 3 || loginName.text.length > 15){
        NSString *message = @"用户名长度要在3～15之间";
        [self registerPrompt:message];
    }else if(firstPassword.text.length < 3 || firstPassword.text.length > 15){
        NSString *message = @"密码长度要在3～15之间";
        [self registerPrompt:message];
    }else if(firstPassword.text == secondPassword.text) {
        [self okClick:@"/mobile/user/register.html"];
    }else{
        NSString *message = @"The two passwords differ";
        [self registerPrompt:message];
    }
    
}

//跟后台交换数据
- (void)okClick:(NSString*)url {
    
    NSInteger sexRow = [sexPicker selectedRowInComponent:0];
    NSInteger gradeRow = [gradePicker selectedRowInComponent:0];
    NSString *gradeValue = [gradePickerArray objectAtIndex:gradeRow];
    NSLog(@"%ld",(long)sexRow);
    NSLog(@"%@",gradeValue);
    
    okBtn.backgroundColor = [UIColor grayColor];
    okBtn.enabled = false;
    
    NSString *param = [NSString stringWithFormat:@"userName=%@&password=%@&sex=%ld&grade=%@", loginName.text,firstPassword.text,(long)sexRow,gradeValue];
    [self requestTck:url _param:param _callback:^(NSMutableDictionary *map){
        
        //map中存放服务器返回的信息
        NSLog(@"HERE IS MAP:\n%@",map);
        NSObject *statusObj = [map objectForKey:@"status"];
        int status = [(NSNumber*)statusObj intValue];
        NSString *message = (NSString*)[map objectForKey:@"message"];
        
        //status表示登录状态结果，1“OK”,2“用户名或密码不规范”,3“用户已存在”
        if (status == 1) {
            //跳转到登录页面
            [self prompt:message];
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginView *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginView"];
            [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            nextPage.fromRegister = 1;
            nextPage.userNameFromRegister = loginName.text;
            nextPage.passwordFromRegister = firstPassword.text;
            [self presentViewController:nextPage animated:YES completion:nil];
        }else{
            //提示错误信息
            [self prompt:message];
            okBtn.backgroundColor = [UIColor clearColor];
            okBtn.enabled = true;
        }
    } is_loading:YES is_backup:NO is_solveFail:YES _frequency:0];
}


#pragma mark- 数据加载到对应的picker
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 0) {
        return [sexPickerArray count];
    }else{
        return [gradePickerArray count];
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    if (pickerView.tag == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.sexPickerArray[row];
        label.minimumFontSize = 8;
        [label setTextAlignment:UITextAlignmentLeft];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont boldSystemFontOfSize:25]];
        label.textColor = [UIColor whiteColor];
        return label;
    }else{
        UILabel *label = [[UILabel alloc] init];
        label.text = self.gradePickerArray[row];
        label.minimumFontSize = 8;
        [label setTextAlignment:UITextAlignmentLeft];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont boldSystemFontOfSize:25]];
        label.textColor = [UIColor whiteColor];
        return label;
    }
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"left");
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginView *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginView"];
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}

@end