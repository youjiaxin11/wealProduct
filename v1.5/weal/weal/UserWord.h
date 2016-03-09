//
//  UserWord.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserWord : NSObject

@property int userWordId;// 主键自增长
@property int userId;//登录者，外键user
@property int wordId;//单词id
@property int test;//单词测试标志

@end
