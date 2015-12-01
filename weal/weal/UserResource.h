//
//  UserResource.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserResource : NSObject

@property int userResourceId;// 主键自增长
@property int userId;//登录者，外键user
@property int resourceId;//资源id
@property int ulearn;//是否学习资源标志
@property int clickcount;//点击次数
@property NSString* uloginTime;//资源学习开始时间
@property NSString* ulogoutTime;//资源学习结束时间

@end

