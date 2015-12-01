//
//  UserTest.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTest : NSObject

@property int userTestId;// 主键自增长
@property int userId;//登录者，外键user
@property int testId;//测试题id
@property int tTest;//是否做过测试标志位
@property int tScore;//测试得分
@end

