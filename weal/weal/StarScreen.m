//
//  StarScreen.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StarScreen.h"
#import "XYZPhoto.h"
#import "WordGuide.h"
#import "LoginView.h"
#import "Robot.h"

#define IMAGEWIDTH 360
#define IMAGEHEIGHT 480

@interface StarScreen ()
@property(nonatomic, strong) NSMutableArray * photos;
@end


@implementation StarScreen
@synthesize user,themeText;
NSArray *themeKeyArray;//9个大主题的编号用数组保存
NSDictionary *themeDictionary;//9个大主题的编号及其英文含义用键值对保存
- (void)viewDidLoad
{
    [super viewDidLoad];
    themeKeyArray = @[@"2-2",@"2-10",@"2-11",@"2-12",@"2-15",@"2-16",@"2-17",@"2-20",@"2-21"];
    
    themeDictionary =@{@"2-2":@"Family, frinends and people around", @"2-10":@"Festivals, holidays and celebrations",@"2-11":@"Shopping",@"2-12":@"Food and drinkss",@"2-15":@"Weather",@"2-16":@"FRecreation and sports",@"2-17":@"Travel and transport",@"2-20":@"Nature",@"2-21":@"The world and the environment"};//9个大主题及其对应的编号
    NSLog(@"star user ::%@", user.loginName );
    self.photos = [[NSMutableArray alloc]init];
//    NSMutableArray *photoPaths = [[NSMutableArray alloc]init];
//    
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    
//    NSLog(@"path =%@", path);
//    
//    NSFileManager *fm = [NSFileManager defaultManager];
//    
//    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
//    for (NSString *fileName in fileNames ) {
//        if ([fileName hasSuffix:@"png"] || [fileName hasSuffix:@"PNG"]) {
//            NSString *photoPath = [path stringByAppendingPathComponent:fileName];
//            [photoPaths addObject:photoPath];
//        }
//    }
    
    
    //添加n个图片到界面中
   // if (photoPaths) {
        for (int i = 0; i < 9; i++) {
            float X = arc4random()%((int)self.view.bounds.size.width - IMAGEWIDTH);
            float Y = arc4random()%((int)self.view.bounds.size.height - IMAGEHEIGHT);
            float W = IMAGEWIDTH;
            float H = IMAGEHEIGHT;
            
            XYZPhoto *photo = [[XYZPhoto alloc]initWithFrame:CGRectMake(X, Y, W, H)];
            //[photo updateImage:[UIImage imageWithContentsOfFile:photoPaths[i]]];
            NSString *name1 = @"topic";
            NSString *name2 = [NSString stringWithFormat:@"%d.png", i+1];
            NSString *name3 = [name1 stringByAppendingString:name2];
            UIImage *photoImage = [UIImage imageNamed:name3];
            //CGSize OriginSize = photoImageOrigin.size;
            //UIImage *photoImage = [self image:photoImageOrigin centerInSize:CGSizeMake(OriginSize.width/5,OriginSize.height/5)];
            [photo updateImage:photoImage];
            photo.photoId = i+1;
            [self.view addSubview:photo];
            
            float alpha = i*1.0/10 + 0.2;
            [photo setImageAlphaAndSpeedAndSize:alpha];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage2:)];
            [photo addGestureRecognizer:tap];
            
            [self.photos addObject:photo];
        }
   // }
    
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
    [singleTap setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTap];
    
    
}

- (UIImage *)image:(UIImage *)image centerInSize:(CGSize)viewsize
{
    UIGraphicsBeginImageContext(CGSizeMake(viewsize.width, viewsize.height));
    [image drawInRect:CGRectMake(0, 0, viewsize.width, viewsize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

- (void)doubleTap {
    
    NSLog(@"DoubleTap...........");
    
    for (XYZPhoto *photo in self.photos) {
        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateBig) {
            return;
        }
    }
    
    float W = self.view.bounds.size.width / 4;
    float H = self.view.bounds.size.height / 4;
    
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photos.count; i++) {
            XYZPhoto *photo = [self.photos objectAtIndex:i];
            
            if (photo.state == XYZPhotoStateNormal) {
                photo.oldAlpha = photo.alpha;
                photo.oldFrame = photo.frame;
                photo.oldSpeed = photo.speed;
                photo.alpha = 1;
                photo.frame = CGRectMake(i%3*W+130, i/3*H+110, W, H);//修改双击图片的位置和大小
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.speed = 0;
                photo.state = XYZPhotoStateTogether;
            } else if (photo.state == XYZPhotoStateTogether) {
                photo.alpha = photo.oldAlpha;
                photo.frame = photo.oldFrame;
                photo.speed = photo.oldSpeed;
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.state = XYZPhotoStateNormal;
            }
        }
        
    }];
    
}

- (void)singleTap {
    
    NSLog(@"SingleTap...........");
    
    for (XYZPhoto *photo in self.photos) {
        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateTogether) {
            return;
        }
    }
    
    
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photos.count; i++) {
            XYZPhoto *photo = [self.photos objectAtIndex:i];
            
            if (photo.state == XYZPhotoStateBig) {
                photo.frame = photo.oldFrame;
                photo.alpha = photo.oldAlpha;
                photo.speed = photo.oldSpeed;
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.state = XYZPhotoStateNormal;
            }
        }
        
    }];
    
}


- (void)tapImage2:(UIGestureRecognizer*)sender {
    
    XYZPhoto *photo = sender.view;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (photo.state == XYZPhotoStateNormal) {
            photo.oldFrame = photo.frame;
            photo.oldAlpha = photo.alpha;
            photo.oldSpeed = photo.speed;
            photo.frame = CGRectMake(50, 120, photo.superview.bounds.size.width - 250, photo.superview.bounds.size.height - 250);//修改单击图片的位置和大小
            photo.imageView.frame = photo.bounds;
            photo.drawView.frame = photo.bounds;
            [photo.superview bringSubviewToFront:photo];
            photo.speed = 0;
            photo.alpha = 1;
            photo.state = XYZPhotoStateBig;
            //取主题键
            NSString *thisThemeKey = [themeKeyArray objectAtIndex:photo.photoId-1];
            NSLog(@"变大按钮对应的主题词为%@",thisThemeKey);
            //取主题值，并呈现在前台
            themeText.text = [themeDictionary objectForKey:thisThemeKey];
            [themeText setBackgroundColor:[UIColor clearColor]];
        }
        else if (photo.state == XYZPhotoStateBig || photo.state == XYZPhotoStateTogether) {
            NSLog(@"跳转photoId:%d",photo.photoId);
//            sender.frame = sender.oldFrame;
//            sender.alpha = sender.oldAlpha;
//            sender.speed = sender.oldSpeed;
//            sender.imageView.frame = sender.bounds;
//            sender.drawView.frame = sender.bounds;
            photo.state = XYZPhotoStateNormal;
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            WordGuide *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"WordGuide"];
            nextPage.userWordGuide = user;
            nextPage.thisThemeKey = [themeKeyArray objectAtIndex:photo.photoId-1];//把主题图片对应的编码传递给下一页
            nextPage.thisThemeValue = [themeDictionary objectForKey:nextPage.thisThemeKey];//把主题传递给下一页
            [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:nextPage animated:YES completion:nil];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"left");
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginView *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginView"];
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}
- (IBAction)RobotBtnAction:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Robot *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"Robot"];
    nextPage.userRobot = user;
    
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
    
}

@end