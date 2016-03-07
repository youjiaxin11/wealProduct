//
//  UploadVideo.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import "BaseControl.h"
@interface UploadVideo : BaseControl{
    NSString *lastChosenMediaType;
    NSString *urlStr;
    UIImageView *contentimageview;
    AVPlayer *player;
}
@property(nonatomic,copy)                NSString *lastChosenMediaType;
@property(nonatomic,copy)                NSString *urlStr;
@property (strong ,nonatomic)            AVPlayer *player;//播放器，用于录制
@property (strong, nonatomic) IBOutlet UIImageView *contentimageview;

@property (strong, nonatomic) IBOutlet UIButton *addVideoBtn;
@property (assign, nonatomic) User* userUploadVideo;//当前登录用户
@end