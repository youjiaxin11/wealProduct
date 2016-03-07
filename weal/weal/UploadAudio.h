//
//  UploadAudio.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import "BaseControl.h"

@interface UploadAudio: BaseControl
@property (assign, nonatomic) User* userUploadAudio;//当前登录用户
@property (assign, nonatomic) Word* wordAudio;//当前单词实体

@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）

@property (weak, nonatomic) IBOutlet UIButton *record;//开始录音
@property (weak, nonatomic) IBOutlet UIButton *pause;//暂停录音
@property (weak, nonatomic) IBOutlet UIButton *resume;//恢复录音
@property (weak, nonatomic) IBOutlet UIButton *stop;//停止录音
@property (weak, nonatomic) IBOutlet UIProgressView *audioPower;//音频波动
@end