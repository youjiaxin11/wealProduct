//
//  TimeUtil.h
//  BXBook
//
//  Created by sunzhong on 15/8/25.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject
//计算当前时间
+(NSString*)getTimeNow;
//计算所有时间间隔
+(NSTimeInterval) allDateContent:(NSString*)_date1 date2:(NSString*)_date2;
//将时间间隔转换为字符串
+(NSString*) computeDateContent:(NSTimeInterval)time;
@end