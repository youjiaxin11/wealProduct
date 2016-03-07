//
//  ResourceCartoon.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceCartoon.h"
#import "WordLearning.h"
#import "ZLSwipeableView.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "CardViewVid.h"

@interface ResourceCartoon () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property (strong, nonatomic) IBOutlet UIButton *groupVideoBtn;

@property (nonatomic, strong) NSArray *colorNames;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic) NSInteger colorIndex;
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) NSMutableArray *filePaths;
@end

@implementation ResourceCartoon
@synthesize userResourceCartoon,wordResourceCartoon;
MPMoviePlayerController *moviePlay;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colorIndex = 0;
    if (wordResourceCartoon.video.count == 0) {
        [self prompt:@"无资源"];
    }else {
    self.count = wordResourceCartoon.video.count;
    }
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
    self.filePaths = [[NSMutableArray alloc]initWithCapacity:self.count];
    for (int i = 0; i < self.count; i++) {
        //NSString* filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
        NSString * filePath = [wordResourceCartoon.video objectAtIndex:i];
       // NSURL *url = [NSURL URLWithString:urlstr];
        //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        [self.filePaths addObject:filePath];
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
    if (self.colorIndex<0) {
        self.colorIndex = 0;
    }
    if (self.colorIndex<self.colors.count) {
        CardViewVid *view = [[CardViewVid alloc] initWithFrame:swipeableView.bounds];
        view.cardColor = [self colorForName:self.colors[self.colorIndex]];
        view.filePath = [self.filePaths objectAtIndex:self.colorIndex];
        self.colorIndex++;
        
        view.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        
        [view addGestureRecognizer:singleTap];
        
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
        nextPage.userWordLearning = userResourceCartoon;
        nextPage.wordLeaning = wordResourceCartoon;
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}

//let me try
- (IBAction)letMeTryAction:(UIButton *)sender {
    self.groupVideoBtn.hidden = NO;
    
}

//小组创编

- (IBAction)groupVideoAction:(UIButton *)sender {
  //  self.groupVideoBtn.hidden = YES;
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UploadVideo *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
    nextPage.userUploadVideo = userResourceCartoon;
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [self presentViewController:nextPage animated:YES completion:nil];
    
    
    
}

-(void)handleSingleTap:(UIGestureRecognizer*)gestureRecognizer{
    NSString *urlStr = [self.filePaths objectAtIndex:self.colorIndex];
    if (urlStr == nil) {
        [self prompt:@"未上传视频"];
    }else{
        //VideoPlay* videoplay;
        //[videoplay Play:urlStr];
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        //视频播放对象
        moviePlay = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [self presentMoviePlayerViewControllerAnimated:moviePlay];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myMovieFinishedCallback:)
                                                     name: MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        moviePlay = nil;
    }
}




-(void)myMovieFinishedCallback:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
//    [moviePlay  dismissMoviePlayerViewControllerAnimated];
//    [moviePlay.moviePlayer stop];
//    moviePlay.moviePlayer.initialPlaybackTime = -1.0;
    moviePlay = nil;
}


    
@end