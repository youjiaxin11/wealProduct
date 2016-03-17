//
//  LearningRecord.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//


#import "BaseControl.h"
@interface LearningRecord : BaseControl
@property (strong, nonatomic) IBOutlet UILabel *goldenLbl;
@property (strong, nonatomic) IBOutlet UILabel *ageLbl;
@property (assign, nonatomic) User* userLearningRecord;//当前登录用户
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UIWebView *webShow;
@end