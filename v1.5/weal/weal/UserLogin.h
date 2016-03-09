//
//  UserLogin.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLogin : NSObject

@property int userLoginId;// 主键
@property int userId;//登录者，外键user
@property NSString* loginTime;//登入时间
@property NSString* logoutTime;//登出时间
@property int loginState;//登录状态


@end
