//
//  Test.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestView.h"
#import "WordLearning.h"

@implementation TestView
@synthesize userTestView;
//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"left");
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WordLearning *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"WordLearning"];
        nextPage.userWordLearning = userTestView;
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}
@end