//
//  Vhelp.h
//  weal
//
//  Created by ding on 15/11/27.
//  Copyright © 2015年 ding. All rights reserved.
//

#import "BaseControl.h"
@interface Vhelp: BaseControl
@property (assign, nonatomic) User* userVhelp;//当前登录用户
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *textView;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@end
