//
//  UserHide.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserHide: NSObject

@property int userHideId;// 主键自增长
@property int userId;//登录者，外键user
@property int hideId;//隐藏关id
@property int hTest;//是否做过隐藏关标志位
@property int hScore;//隐藏关得分
@end
