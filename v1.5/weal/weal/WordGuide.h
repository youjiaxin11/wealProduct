//
//  WordGuide.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import "BaseControl.h"
@interface WordGuide : BaseControl
@property (assign, nonatomic) User* userWordGuide;//当前登录用户
@property (strong, nonatomic) IBOutlet UIButton *star1;
@end
