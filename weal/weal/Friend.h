//
//  Friend.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Friend: NSObject

@property int friendId;// 主键自增长
@property int userId1;//登录者1，外键user
@property int userId2;//登录者2，外键user
@property int frendship;//双方关系
@end

