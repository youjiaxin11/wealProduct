//
//  WordLearning.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//
#import "BaseControl.h"
@interface WordLearning : BaseControl
@property (assign, nonatomic) User* userWordLearning;//当前登录用户
@property (assign, nonatomic) NSString* thisWord;//当前单词
@property (assign, nonatomic) Word* wordLeaning;//当前单词
@property (assign, nonatomic) NSString * thisThemeKey1;//当前大主题对应的数字编码
@property (assign, nonatomic) NSString * thisThemeValue1;//当前大主题
@end

