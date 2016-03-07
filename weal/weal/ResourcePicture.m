//
//  ResourcePicture.m
//  weal
//
//  Created by sunzhong on 16/3/1.
//  Copyright © 2016年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourcePicture.h"
#import "WordLearning.h"
#import "ZLSwipeableView.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "CardViewPic.h"

@interface ResourcePicture () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
//@property (strong, nonatomic) IBOutlet UIButton *recordBtn;
@property (strong, nonatomic) IBOutlet UIButton *paintBtn;
@property (strong, nonatomic) IBOutlet UIButton *groupVideoBtn;


@property (nonatomic) NSInteger colorIndex;

@property (nonatomic) NSInteger count;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSArray *colorNames;

@end

@implementation ResourcePicture
@synthesize userResourcePicture,wordResourcePicture,count;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (wordResourcePicture.picture.count == 0) {
        [self prompt:@"无资源"];
    }else {
       
    self.count = wordResourcePicture.picture.count;//卡片个数
         NSLog(@"here!!!%d",self.count);
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
    self.images = [[NSMutableArray alloc]initWithCapacity:self.count];
    for (int i = 0; i < self.count; i++) {
        NSString* urlstr = [root_url stringByAppendingString:[wordResourcePicture.picture objectAtIndex:i]];
        NSLog(@"urlstr%@",urlstr);
        NSURL *url = [NSURL URLWithString:urlstr];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        if (image != nil) {
            [self.images addObject:image];
        }else {
            NSLog(@"第%d张图片读取失败",i+1);
        }
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
        CardViewPic *view = [[CardViewPic alloc] initWithFrame:swipeableView.bounds];
        view.cardColor = [self colorForName:self.colors[self.colorIndex]];
        view.cardImage = [self.images objectAtIndex:self.colorIndex];
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
        nextPage.userWordLearning = userResourcePicture;
        nextPage.wordLeaning = wordResourcePicture;
        [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextPage animated:YES completion:nil];
    }
}


//let me try
- (IBAction)letMeTryAction:(UIButton *)sender {
    self.paintBtn.hidden = NO;
    //self.recordBtn.hidden = NO;
    self.groupVideoBtn.hidden = NO;
    
}
////录音
//- (IBAction)recordAction:(UIButton *)sender {
//    self.recordBtn.hidden = YES;
//    self.paintBtn.hidden = YES;
//    self.groupVideoBtn.hidden = YES;
//    
//}
//画画
- (IBAction)paintAction:(UIButton *)sender {
  //  self.recordBtn.hidden = YES;
   // self.paintBtn.hidden = YES;
   // self.groupVideoBtn.hidden = YES;
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UploadPhoto *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
    nextPage.userUploadPhoto = userResourcePicture;
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
}
//小组创编

- (IBAction)groupVideoAction:(UIButton *)sender {
  //  self.recordBtn.hidden = YES;
 //   self.paintBtn.hidden = YES;
 //   self.groupVideoBtn.hidden = YES;
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UploadVideo *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
    nextPage.userUploadVideo = userResourcePicture;
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [self presentViewController:nextPage animated:YES completion:nil];
    
    
    
}
@end
