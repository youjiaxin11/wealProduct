//
//  CardViewVid.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

//对应resourceword，显示单词的音形义

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CardViewVid : UIView
@property UIColor *cardColor;
@property UIImage *cardImage;
@property(nonatomic,retain)  IBOutlet   UIView *contentimageview;
@property (strong ,nonatomic) AVPlayer *player;//播放器，用于录制完视频后播放视频

@property (strong ,nonatomic) NSString *filePath;
@end
