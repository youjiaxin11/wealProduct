//
//  TimeUtil.m
//  BXBook
//
//  Created by sunzhong on 15/8/25.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil

+(NSString*)getTimeNow{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

+(NSTimeInterval) allDateContent:(NSString*)_date1 date2:(NSString*)_date2{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date1 = [dateformatter dateFromString:_date1];
    NSDate* date2 = [dateformatter dateFromString:_date2];
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    return time;
}

+(NSString*) computeDateContent:(NSTimeInterval)time{
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600 - days*24;
    int minutes = ((int)time)%(3600*24)/60 - hours*60;
    NSString *dateContent = [[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minutes];
    return dateContent;
}

@end