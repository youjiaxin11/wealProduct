//
//  UploadPhoto.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadPhoto.h"
#import "MKNetworkEngine.h"

@implementation UploadPhoto
@synthesize userUploadPhoto,contentImageView,lastChosenMediaType;

NSString* str2_photo;
NSString* str3_photo;
NSString* str4_photo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [contentImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    contentImageView.contentMode =  UIViewContentModeScaleAspectFit;
    //contentImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    contentImageView.clipsToBounds  = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addPhoto:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请选择图片来源" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [alert show];
}
- (IBAction)uploadPhoto:(id)sender {
    NSLog(@"开始上传Photo文件");
    //读取图片数据，设置压缩系数为0.5.
    NSData *imageData = UIImageJPEGRepresentation(_UPImage, 0.5);
    // 获取沙盒目录
    NSLog(@"图片保存path:%@",_UPFullPath);
    [imageData writeToFile:_UPFullPath atomically:NO];
    // 使用MKNetworkKit 上传图片和数据
    
    NSDictionary* postvalues = [NSDictionary dictionaryWithObjectsAndKeys:@"mknetwork",@"file",nil];
    MKNetworkEngine* UPEngine = [[MKNetworkEngine alloc] init] ;
    MKNetworkOperation* UPOperation = [UPEngine operationWithURLString:@"http://172.19.203.8:8080/iqasweb/mobile/ios/work/uploadWork.html" params:postvalues httpMethod:@"POST"];
    [UPOperation addFile:_UPFullPath forKey:@"file"];
    [UPOperation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"Photo成功了?是的，成功了！");
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
        //保存在本地相册
        UIImage *chosenImage=[info objectForKey:UIImagePickerControllerEditedImage];
        contentImageView.image = chosenImage;
        UIImageWriteToSavedPhotosAlbum(contentImageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contexInfo:), nil );
        _UPImage = chosenImage;
        
        //获取当前时间
        NSString* timeNow = [TimeUtil getTimeNow];
        //保存在本机沙盒
        str2_photo = @"";
        str3_photo = [str2_photo stringByAppendingString:timeNow];
        str4_photo = [str3_photo stringByAppendingString:@"+photo.png"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:str4_photo];   // 保存文件的名称
        _UPFullPath = filePath;
        [UIImagePNGRepresentation(chosenImage)writeToFile: filePath  atomically:YES];
    }
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediaTypes count]>0){
        
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes = mediatypes;
        picker.delegate = self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredMediaType=(NSString *)kUTTypeImage;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredMediaType];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}

-(void) imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:(NSError*)error contexInfo:(void*) contextInfo{
    if (!error) {
        // [self prompt:@"成功保存到本地相册"];
    }else {
        // [self prompt:[error description]];
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