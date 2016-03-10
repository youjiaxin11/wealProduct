//
//  Register.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import "BaseControl.h"
#import "LoginView.h"
@interface Register : BaseControl

//界面展示框
@property (strong, nonatomic) IBOutlet UITextField *loginName;
@property (strong, nonatomic) IBOutlet UITextField *firstPassword;
@property (strong, nonatomic) IBOutlet UITextField *secondPassword;
@property (strong, nonatomic) IBOutlet UIPickerView *sexPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *gradePicker;


//操作按钮
@property (strong, nonatomic) IBOutlet UIButton *okBtn;

//选择器初始化数组
@property (strong,nonatomic) NSArray *sexPickerArray;
@property (strong,nonatomic) NSArray *gradePickerArray;


@end