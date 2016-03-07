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
#import "WordLearning.h"

@implementation WordGuide
@synthesize userWordGuide;

NSString *wordSelected = @"boat";

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"left");
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        StarScreen *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"StarScreen"];
        nextPage.user = userWordGuide;
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}
- (IBAction)star1Action:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WordLearning *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"WordLearning"];
    nextPage.userWordLearning = userWordGuide;
    nextPage.thisWord = wordSelected;
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
}

@end