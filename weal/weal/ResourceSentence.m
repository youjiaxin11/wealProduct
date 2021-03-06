//
//  ResourceSentence.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceSentence.h"
#import "WordLearning.h"
#import "ZLSwipeableView.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
#import "UploadAudio.h"

@interface ResourceSentence () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;

@property (nonatomic) NSInteger colorIndex;
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) NSArray *colorNames;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSMutableArray *texts;
@end

@implementation ResourceSentence
@synthesize userResourceSentence,wordResourceSentence;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (wordResourceSentence.sentence.count == 0) {
        [self prompt:@"无资源"];
    }else {
    self.count = wordResourceSentence.sentence.count;//卡片个数
    }
    
    //设置颜色数组数据源
    self.colorIndex = 0;
    self.colorNames = @[
                        @"Turquoise",
                        @"Green Sea",
                        @"Emerald",
                        @"Nephritis",
                        @"Peter River",
                        @"Belize Hole",
                        @"Amethyst",
                        @"Wisteria",
                        @"Wet Asphalt",
                        @"Midnight Blue",
                        @"Sun Flower",
                        @"Orange",
                        @"Carrot",
                        @"Pumpkin",
                        @"Alizarin",
                        @"Pomegranate",
                        @"Clouds",
                        @"Silver",
                        @"Concrete",
                        @"Asbestos",
                        ];
    self.colors = [[NSMutableArray alloc]initWithCapacity:self.count];
    for (int i = 0; i < self.count; i++) {
        NSString *color;
        int j = i;
        if (j >= 20) {
            j = j - 20;
        }
        color = [[NSString alloc]initWithString:self.colorNames[j]];
        [self.colors addObject:color];
    }
    
    //设置要现实的文字数组数据源
    self.texts = [[NSMutableArray alloc]initWithCapacity:self.count];
    for (int i = 0; i < self.count; i++) {
        //NSString *text = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%d",i]];
        NSString *text = [wordResourceSentence.sentence objectAtIndex:i];
        [self.texts addObject:text];
    }
    // ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:self.view.frame];
    // [self.view addSubview:swipeableView];
    
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    
    // required data source
    self.swipeableView.dataSource = self;
    
    // optional delegate
    self.swipeableView.delegate = self;
}
- (IBAction)swipeLeftButtonAction:(UIButton *)sender {
    NSLog(@"colorIndex:%d",self.colorIndex);
    [self.swipeableView swipeTopViewToLeft];
}
- (IBAction)swipeRightButtonAction:(UIButton *)sender {
    NSLog(@"colorIndex:%d",self.colorIndex);
    [self.swipeableView swipeTopViewToRight];
}

- (IBAction)reloadButtonAction:(UIButton *)sender {
    NSLog(@"colorIndex:%d",self.colorIndex);
    //if(self.colorIndex >= 4 && self.colorIndex<=16){
    self.colorIndex = self.colorIndex-4;
    //  self.colorIndex = 0;
    [self.swipeableView discardAllSwipeableViews];
    [self.swipeableView loadNextSwipeableViewsIfNeeded];
    // }
    
}

#pragma mark - ZLSwipeableViewDelegate
- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view {
    NSLog(@"did swipe left");
}
- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view {
    NSLog(@"did swipe right");
}
- (void)swipeableView: (ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location {
    NSLog(@"swiping at location: x %f, y%f", location.x, location.y);
}

#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    NSLog(@"!!!!!填充卡片view适配");
    
    if (self.colorIndex<0) {
        self.colorIndex = 0;
    }
    if (self.colorIndex<self.colors.count) {
        //在这里修改卡片的数据源
        CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
        view.cardColor = [self colorForName:self.colors[self.colorIndex]];
        view.cardText = [self.texts objectAtIndex:self.colorIndex];
        NSLog(@"填充text%@",[self.texts objectAtIndex:self.colorIndex]);
        self.colorIndex++;
        return view;
    }
    return nil;
}

#pragma mark - ()
- (UIColor *)colorForName:(NSString *)name
{
    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
    Class colorClass = [UIColor class];
    return [colorClass performSelector:NSSelectorFromString(selectorString)];
}



//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"left");
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WordLearning *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"WordLearning"];
        nextPage.userWordLearning = userResourceSentence;
        nextPage.wordLeaning = wordResourceSentence;
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}

//let me try
- (IBAction)letMeTryAction:(UIButton *)sender {
    self.recordBtn.hidden = NO;
    
}
//录音
- (IBAction)recordAction:(UIButton *)sender {
  //  self.recordBtn.hidden = YES;
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UploadAudio *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
    nextPage.userUploadAudio = userResourceSentence;
    nextPage.wordAudio = wordResourceSentence;
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
    
}
@end