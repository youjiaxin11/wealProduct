//
//  WordGuide.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordGuide.h"
#import "StarScreen.h"

@implementation WordGuide

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"left");
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        StarScreen *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"StarScreen"];
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}

@end