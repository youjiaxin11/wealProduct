//
//  User.m
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@implementation User

@synthesize userId;// 主键自增长
@synthesize loginName;// 登录名
@synthesize password;//密码
@synthesize role;//身份
@synthesize realName;
@synthesize sex;// 性别
@synthesize school;//学校
@synthesize grade;//年级
@synthesize classNum;//班级
@synthesize golden;//金币数
@synthesize  rank;//排行
@synthesize loginTimes;
@synthesize medal;//勋章
@synthesize wordCount;//已学习单词个数
@synthesize workCount;//上传作品个数
@synthesize birthYear;//出生年份
@synthesize createTime;
@end