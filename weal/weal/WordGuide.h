//
//  WordGuide.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import "BaseControl.h"
@interface WordGuide : BaseControl
@property (assign, nonatomic) User* userWordGuide;//当前登录用户
@property (assign, nonatomic) NSString * thisThemeKey;//当前大主题对应的数字编码
@property (assign, nonatomic) NSString * thisThemeValue;//当前大主题

@property (strong, nonatomic) NSMutableArray *secondeThemeKey;//使用动态数组存储小主题对应的数字编码
@property (strong, nonatomic) NSMutableArray *secondeTheme;//使用动态数组存储小主题

@property (strong, nonatomic) NSMutableArray *secondeThemeAllInfo;//使用动态数组存储小主题及其所有单词

@property (strong, nonatomic) NSMutableArray *secondeThemeAllWords;//使用动态数组存储小主题下的所有单词
@property (strong, nonatomic) UIImageView *imageViewlineshow;
@property (strong, nonatomic) UIImageView *imageViewlineshow1;
@property (assign, nonatomic) int fromnextpage;
@end
