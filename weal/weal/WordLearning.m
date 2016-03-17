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
#import "ResourcePicture.h"

#define IMAGEWIDTH 360
#define IMAGEHEIGHT 480

@interface WordLearning ()
@property(nonatomic, strong) NSMutableArray * photos;
@end

@implementation WordLearning
@synthesize userWordLearning,thisWord,wordLeaning,thisThemeKey1,thisThemeValue1;
Word *word;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.photos = [[NSMutableArray alloc]init];
    
    //添加n个图片到界面中
    // if (photoPaths) {
    for (int i = 0; i < 6; i++) {
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
    
    //测试用例！！！！
    thisWord = @"boat";
    ////
    
    
    
    if (thisWord == nil||[thisWord isEqualToString:@""]) {
        NSLog(@"单词为空");
    }else{
        if (wordLeaning == nil) {
            [self getResource:@"mobile/ios/word/findWord.html"];
        }else{
            word = wordLeaning;
        }
      //  NSLog(@"thisword:%@", word.word);

    }

    
    
    
}

- (void)getResource:(NSString*)url {
    
    NSString *param = [NSString stringWithFormat:@"text=%@",@"boat"];
    [self requestTck:url _param:param _callback:^(NSMutableDictionary *map){
        //map中存放服务器返回的信息
        NSLog(@"HERE IS MAP:\n%@",map);
        NSObject *statusObj = [map objectForKey:@"status"];
        int status = [(NSNumber*)statusObj intValue];
        NSString *message = (NSString*)[map objectForKey:@"message"];
        //status表示结果，1代表成功
        if (status == 1) {
            NSMutableDictionary *result = [map objectForKey:@"result"];
            NSMutableDictionary *data = [[result objectForKey:@"data"] lastObject];
            NSLog(@"word\n%@",data);
            
            word = [self getWord:data];
            
//            //测试用
//            NSString* str2 =  (NSString*)[data objectForKey:@"pictruepath"];
//            NSArray* ar2 = [[NSArray alloc]initWithArray:[self encodeUrl:str2]];
//            NSLog(@"ar2:%@",ar2);
//            word = [[Word alloc]init];
//            word.picture = ar2;
//            NSLog(@"word.picture:%@",word.picture);
            
        }else{
            //提示错误
            [self prompt:message];
        }
    } is_loading:YES is_backup:NO is_solveFail:YES _frequency:0];
    
}

- (Word*)getWord:(NSMutableDictionary*)data{
    //接收word全部信息
    Word* word = [[Word alloc]init];
    word.wordId = (NSString*)[data objectForKey:@"wordId"];
    word.word = (NSString*)[data objectForKey:@"word"];
    
    NSString *str1,*str2,*str3,*str4,*str5,*str6;
    str1 =  (NSString*)[data objectForKey:@"meanings"];
    str2 =  (NSString*)[data objectForKey:@"pictures"];
    str3 =  (NSString*)[data objectForKey:@"sentences"];
    str4 =  (NSString*)[data objectForKey:@"dialogues"];
    str5 =  (NSString*)[data objectForKey:@"videos"];
    str6 =  (NSString*)[data objectForKey:@"picturebooks"];
    
    NSArray* urlArray1 = [[NSArray alloc]initWithArray:[self encodeUrl:str1]];
    NSArray* urlArray2 = [[NSArray alloc]initWithArray:[self encodeUrl:str2]];
    NSArray* urlArray3 = [[NSArray alloc]initWithArray:[self encodeUrl:str3]];
    NSArray* urlArray4 = [[NSArray alloc]initWithArray:[self encodeUrl:str4]];
    NSArray* urlArray5 = [[NSArray alloc]initWithArray:[self encodeUrl:str5]];
    NSArray* urlArray6 = [[NSArray alloc]initWithArray:[self encodeUrl:str6]];
    
    NSLog(@"urlArray4:%@",urlArray4);
    
    word.meaning = urlArray1;
    word.picture = urlArray2;
    word.sentence = urlArray3;
    word.dialogue = urlArray4;
    word.video = urlArray5;
    word.picturebook = urlArray6;
    
    NSLog(@"HERE IS Word:\n%@",word);

    return word;
}

- (NSArray*) encodeUrl:(NSString*)str {
    //解析写在这里
   // NSMutableArray* urlArray = [[NSMutableArray alloc]init];
    
    NSArray *array = [str componentsSeparatedByString:@"@"];
    return array;
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
            if (photo.photoId == 1) {//单词形和义
                ResourceWord *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourceWord"];
                nextPage.userResourceWord = userWordLearning;
                nextPage.wordResourceWord = word;
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
            }else if (photo.photoId == 3) {//句子
                ResourceSentence *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourceSentence"];
                nextPage.userResourceSentence = userWordLearning;
                nextPage.wordResourceSentence = word;
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
            }else if (photo.photoId == 4) {//段落
                ResourceStory *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourceStory"];
                nextPage.userResourceStory = userWordLearning;
                nextPage.wordResourceStory = word;
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
            }else if (photo.photoId == 5) {//视频动画
                ResourceCartoon *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourceCartoon"];
                nextPage.userResourceCartoon = userWordLearning;
                nextPage.wordResourceCartoon = word;
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
            }else if (photo.photoId == 6) {//绘本
                ResourcePainting *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourcePainting"];
                nextPage.userResourcePainting = userWordLearning;
                nextPage.wordResourcePainting = word;
                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:nextPage animated:YES completion:nil];
//            }else if (photo.photoId == 6) {//测试
//                TestView *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"TestView"];
//                [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//                nextPage.userTestView = userWordLearning;
//                [self presentViewController:nextPage animated:YES completion:nil];
//            }
            }else if (photo.photoId == 2) {//单词本身图片
                ResourcePicture *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"ResourcePicture"];
                nextPage.userResourcePicture = userWordLearning;
                nextPage.wordResourcePicture = word;
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
        nextPage.userWordGuide = userWordLearning;
        nextPage.thisThemeKey = thisThemeKey1;//把主题图片对应的编码传递给下一页
        nextPage.thisThemeValue = thisThemeValue1;//把主题传递给下一页
        nextPage.fromnextpage=1;
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}

@end