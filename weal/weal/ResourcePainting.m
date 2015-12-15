//
//  ResourcePainting.m
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourcePainting.h"
#import "WordLearning.h"
#import "ZLSwipeableView.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"

@interface ResourcePainting () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;
@property (strong, nonatomic) IBOutlet UIButton *paintBtn;
@property (strong, nonatomic) IBOutlet UIButton *groupVideoBtn;

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) NSInteger colorIndex;
@end

@implementation ResourcePainting

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"paint!!!");
    // Do any additional setup after loading the view, typically from a nib.
    self.colorIndex = 0;
    self.colors = @[
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
        CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
        view.cardColor = [self colorForName:self.colors[self.colorIndex]];
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
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}


//let me try
- (IBAction)letMeTryAction:(UIButton *)sender {
    self.paintBtn.hidden = NO;
    self.recordBtn.hidden = NO;
    self.groupVideoBtn.hidden = NO;
    
}
//录音
- (IBAction)recordAction:(UIButton *)sender {
    self.recordBtn.hidden = YES;
    self.paintBtn.hidden = YES;
    self.groupVideoBtn.hidden = YES;
    
}
//画画
- (IBAction)paintAction:(UIButton *)sender {
    self.recordBtn.hidden = YES;
    self.paintBtn.hidden = YES;
    self.groupVideoBtn.hidden = YES;
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UploadPhoto *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
}
//小组创编

- (IBAction)groupVideoAction:(UIButton *)sender {
    self.recordBtn.hidden = YES;
    self.paintBtn.hidden = YES;
    self.groupVideoBtn.hidden = YES;
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UploadVideo *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
    
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [self presentViewController:nextPage animated:YES completion:nil];
    
    
    
}
@end