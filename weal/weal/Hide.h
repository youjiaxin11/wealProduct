//
//  Hide.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hide : NSObject

@property int hideId;// 主键自增长
@property int hType;//隐藏关类型
@property NSString* hUrl;//隐藏关地址

@end
