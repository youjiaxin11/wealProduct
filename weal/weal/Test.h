//
//  Test.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Test : NSObject

@property int testId;// 主键自增长
@property int wordId;//单词id
@property NSString* tUrl;//测试题地址
@property int testdifficulty;//测试题难度
@property int tType;//测试题类型
@property int ability;//考察能力
@end

