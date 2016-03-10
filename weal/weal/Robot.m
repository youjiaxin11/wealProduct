//
//  Robot.m
//  weal
//
//  Created by sunzhong on 16/3/7.
//  Copyright © 2016年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Robot.h"
#import "LearningRecord.h"
#import "Myfriend.h"
#import "Vhelp.h"
#import "MyWork.h"

@implementation Robot
@synthesize userRobot;

- (IBAction)RecordsBtnAction:(id)sender {
    //跳转
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LearningRecord *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"LearningRecord"];
    nextPage.userLearningRecord = userRobot;
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
}
- (IBAction)FriendsBtnAction:(id)sender {
    //跳转
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Myfriend *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"Myfriend"];
    nextPage.userMyfriend = userRobot;
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
}
- (IBAction)WorksBtnAction:(id)sender {
    //跳转
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyWork *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"MyWork"];
     nextPage.userMywork = userRobot;
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
}
- (IBAction)HelpBtnAction:(id)sender {
    //跳转
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Vhelp *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"Vhelp"];
     nextPage.userVhelp = userRobot;
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
}
//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
