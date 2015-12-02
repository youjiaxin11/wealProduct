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

#define IMAGEWIDTH 360
#define IMAGEHEIGHT 480

@interface StarScreen ()
@property(nonatomic, strong) NSMutableArray * photos;
@end


@implementation StarScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
        for (int i = 0; i < 8; i++) {
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
            [photo updateImage:photoImage];
            [self.view addSubview:photo];
            
            float alpha = i*1.0/10 + 0.2;
            [photo setImageAlphaAndSpeedAndSize:alpha];
            
            [self.photos addObject:photo];
        }
   // }
    
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
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
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end