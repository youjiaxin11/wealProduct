//
//  BaseControl.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "User.h"
#import "Resource.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoPlay.h"
#import "MediaPlayer/MPMoviePlayerController.h"
#import "Word.h"
#import "TimeUtil.h"
#import "Friend.h"

#define root_url @"http://172.19.203.158:8080/iqasweb/"



typedef void(^ResponseCallback)(NSMutableDictionary*);

@interface BaseControl : UIViewController<UIAlertViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AVAudioRecorderDelegate,UICollectionViewDelegate,UITableViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>

// 这两个属性要记得手动清空
@property NSString* fromControl;
@property NSMutableDictionary *fromMap;


@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

#pragma mark 请求TCK服务器
#pragma _partUrl 接口路径，只需要后面一截
#pragma _param 参数，多个参数用&隔开
#pragma _callback 回调函数的block
#pragma is_loading 如果为yes就表示要开启一个UIActivityIndicatorView
#pragma is_backup 是否需要备份数据(一般查询的数据需要备份，提交的数据不需要)
#pragma is_solveFail 调用接口失败时，是否内部处理错误
#pragma _frequency 调用接口的频率(单位：秒)，及时调接口，就传入0
- (void)requestTck:(NSString*)_partUrl _param:(NSString*)_param _callback:(ResponseCallback)_callback is_loading:(BOOL)is_loading is_backup:(BOOL)is_backup is_solveFail:(BOOL)is_solveFail _frequency:(int)_frequency;

#pragma mark 在底部弹出一个黑色的提示条
- (void)prompt:(NSString*)msg;

//左滑和右滑的实现
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender;

//register的页面提示
- (void)registerPrompt:(NSString*)msg;
@end