//
//  UploadVideo.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadVideo.h"
#import "MKNetworkEngine.h"

@implementation UploadVideo
@synthesize userUploadVideo,lastChosenMediaType,urlStr,player,contentimageview;

MPMoviePlayerViewController *movieUpload;

NSString* str2_video;
NSString* str3_video;
NSString* str4_video;

- (void)viewDidLoad {
    [super viewDidLoad];
    contentimageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [contentimageview addGestureRecognizer:singleTap];
}

-(void)handleSingleTap:(UIGestureRecognizer*)gestureRecognizer{
    if (urlStr == nil) {
        [self prompt:@"未上传视频"];
    }else{
        //VideoPlay* videoplay;
        //[videoplay Play:urlStr];
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        //视频播放对象
        movieUpload = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [self presentMoviePlayerViewControllerAnimated:movieUpload];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myMovieFinishedCallback:)
                                                     name: MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        movieUpload = nil;
    }
}

-(void)myMovieFinishedCallback:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [movieUpload  dismissMoviePlayerViewControllerAnimated];
    [movieUpload.moviePlayer stop];
    movieUpload.moviePlayer.initialPlaybackTime = -1.0;
    movieUpload = nil;
}

- (IBAction)addVideo:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请选择视频来源" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍摄",@"从手机相册选择", nil];
    [alert show];
}
- (IBAction)addUVVideo:(id)sender {
    NSLog(@"开始上传Video文件");
    
    // 获取沙盒目录
    NSLog(@"Video保存path:%@",_UVFullPath);
    
    // 使用MKNetworkKit 上传图片和数据
    NSDictionary* postvalues = [NSDictionary dictionaryWithObjectsAndKeys:@"mknetwork",@"file",nil];
    MKNetworkEngine* UPEngine = [[MKNetworkEngine alloc] init] ;
    
    NSString *str =[root_url stringByAppendingString:@"mobile/ios/work/uploadWork.html"];
    MKNetworkOperation* UPOperation = [UPEngine operationWithURLString:str params:postvalues httpMethod:@"POST"];
    [UPOperation addFile:_UVFullPath forKey:@"file"];
    [UPOperation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"Video成功了?是的，成功了！");
        [self prompt:@"Well done!"];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"mknetwork error : %@",error.debugDescription);
    }];
    [UPEngine enqueueOperation:UPOperation];

}
#pragma 拍照选择模块
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1)
        [self shootPictureOrVideo];
    else if(buttonIndex==2)
        [self selectExistingPictureOrVideo];
}
#pragma  mark- 拍照模块
//从相机上选择
-(void)shootPictureOrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
//从相册中选择
-(void)selectExistingPictureOrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma 拍照模块
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.lastChosenMediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeImage])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持视频格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
    
    
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
    {
        NSLog(@"video...");
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        urlStr=[url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
        }
        
        //获取当前时间
        NSString* timeNow = [TimeUtil getTimeNow];
        
        //保存到本地沙盒
        //str1_video = [userUploadVideo.loginName stringByAppendingString:@"+"];
        str2_video = @"";
        str3_video = [str2_video stringByAppendingString:timeNow];
        str4_video = [str3_video stringByAppendingString:@"+video.mp4"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:str4_video];   // 保存文件的名称
        //   [UIImagePNGRepresentation(chosenImage) writeToFile: filePath  atomically:YES];
        NSData  *myData = [[NSData  alloc] initWithContentsOfFile: urlStr ];
        [myData writeToFile:filePath atomically: YES ];
        _UVFullPath = filePath;
        
        //录制完之后自动播放
        player=[AVPlayer playerWithURL:url];
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:player];
        //    playerLayer.frame=self.contentimageview.frame;
        playerLayer.frame=CGRectMake(0, 0, self.contentimageview.frame.size.width, self.contentimageview.frame.size.height);
        [self.contentimageview.layer addSublayer:playerLayer];
        _UVPlayer = player;
        [player play];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediatypes;
        picker.delegate = self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredmediatype=(NSString *)kUTTypeMovie;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
    
}

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}

-(void) imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:(NSError*)error contexInfo:(void*) contextInfo{
    if (!error) {
        [self prompt:@"成功保存到本地相册"];
    }else {
        [self prompt:[error description]];
    }
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end