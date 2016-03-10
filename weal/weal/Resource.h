//
//  Resource.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resource : NSObject

@property int resourceId;// 主键自增长
@property int wordId;//单词id
@property NSString* soundUrl;//单词发音地址
@property NSString* rUrl;//资源地址
@property int resourcedifficulty;//资源难度
@property int rType;//资源类型
@property int rgolden;//资源权重，金币数
@property int rscore;//资源得分
@property int rclick;//资源点击量
@end

