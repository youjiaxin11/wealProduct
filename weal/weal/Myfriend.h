//
//  Myfriend.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import "BaseControl.h"
@interface Myfriend: BaseControl
@property (assign, nonatomic) User* userMyfriend;//当前登录用户
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;
@end
