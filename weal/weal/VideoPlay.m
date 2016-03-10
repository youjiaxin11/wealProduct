//
//  VideoPlay.m
//  BXBook
//
//  Created by sunzhong on 15/7/8.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoPlay.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPlay (MPMoviePlayerViewController)

@end

@implementation VideoPlay
{
    MPMoviePlayerViewController *movie;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //利用自带MPMoviePlayerController来实现视频播放,首先要在 项目中导入MediaPlayer.Framework框架包.
    //在试图控制器中导入#import "MediaPlayer/MPMoviePlayerController.h"
    
}
- (IBAction)videoPlay:(id)sender {
    //视频文件路径,此视频已经存入项目包中.属于本地播放
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    //视频URL
    NSURL *url = [NSURL fileURLWithPath:path];
    //视频播放对象
    movie = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentMoviePlayerViewControllerAnimated:movie];
}


- (void)Play:(NSString *)urlStr {
    //视频文件路径,此视频已经存入项目包中.属于本地播放
   // NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    //视频URL
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    //视频播放对象
    movie = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentMoviePlayerViewControllerAnimated:movie];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end