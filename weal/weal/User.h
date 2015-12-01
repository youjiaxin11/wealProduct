//
//  User.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property int userId;// 主键自增长
@property NSString *loginName;// 登录名
@property NSString *password;//密码
@property NSString *realName;
@property int sex;// 性别
@property int role;// 身份
@property int school;//学校
@property int grade;//年级
@property int classNum;//班级
@property int golden;//金币数
@property int medal;//勋章
@property int rank;//排行
@property int loginTimes;// 登陆次数
@property int wordcount;//已学习单词个数
@property int workcount;//上传作品个数
@end
