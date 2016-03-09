//
//  Work.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Work : NSObject
@property int workId;// 主键自增长
@property int userId;// userid
@property int wordId;//单词id
@property NSString* taskUrl;//作品地址
@property NSString* uploadTime;//上传作品时间
@property int wType;//作品类型
@property int golden;//金币数
@property int score;//作品得分
@property int location;//作品地址
@property int viewTimes;//浏览人次
@end

