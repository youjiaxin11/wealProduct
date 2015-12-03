//
//  WordLearning.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordLearning.h"
#import "WordGuide.h"
#import "XYZPhoto.h"
#import "ResourceWord.h"
#import "ResourceSentence.h"
#import "ResourceStory.h"
#import "ResourcePainting.h"
#import "ResourceCartoon.h"
#import "TestView.h"

#define IMAGEWIDTH 360
#define IMAGEHEIGHT 480

@interface WordLearning ()
@property(nonatomic, strong) NSMutableArray * photos;
@end

@implementation WordLearning

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photos = [[NSMutableArray alloc]init];
    
    //添加n个图片到界面中
    // if (photoPaths) {
    for (int i = 0; i < 7; i++) {
        float X = arc4random()%((int)self.view.bounds.size.width - IMAGEWIDTH);
        float Y = arc4random()%((int)self.view.bounds.size.height - IMAGEHEIGHT);
        float W = IMAGEWIDTH;
        float H = IMAGEHEIGHT;
        
        XYZPhoto *photo = [[XYZPhoto alloc]initWithFrame:CGRectMake(X, Y, W, H)];
        //[photo updateImage:[UIImage imageWithContentsOfFile:photoPaths[i]]];
        NSString *name1 = @"ship";
        NSString *name2 = [NSString stringWithFormat:@"%d.png", i+1];
        NSString *name3 = [name1 stringByAppendingString:name2];
        UIImage *photoImage = [UIImage imageNamed:name3];

        [photo updateImage:photoImage];
        photo.photoId = i+1;
        [self.view addSubview:photo];
        
        float alpha = i*1.0/10 + 0.2;
        [photo setImageAlphaAndSpeedAndSize:alpha];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
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


- (void)tapImage:(UIGestureRecognizer*)sender {
    
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
            
        } else if (photo.state == XYZPhotoStateBig || photo.state == XYZPhotoStateTogether) {
            NSLog(@"跳转photoId:%d",photo.photoId);
            photo.state = XYZPhotoStateNormal;
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            if (photo.photoId == 1) {//单词
                ResourceWord *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourceWord"];
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
            }else if (photo.photoId == 2) {//句子
                ResourceSentence *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourceSentence"];
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
            }else if (photo.photoId == 3) {//故事
                ResourceStory *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourceStory"];
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
            }else if (photo.photoId == 4) {//动画
                ResourceCartoon *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourceCartoon"];
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
            }else if (photo.photoId == 5) {//绘本
                ResourcePainting *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourcePainting"];
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
            }else if (photo.photoId == 6) {//测试
                TestView *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"TestView"];
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
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
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WordGuide *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"WordGuide"];
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}

@end