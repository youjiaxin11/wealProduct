//
//  CardView.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "CardView.h"

@implementation CardView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //// Color Declarations
        UIColor* shadowColor2 = [UIColor colorWithRed: 0.209 green: 0.209 blue: 0.209 alpha: 1];
        
        //// Shadow Declarations
        UIColor* shadow = [shadowColor2 colorWithAlphaComponent: 0.73];
        CGSize shadowOffset = CGSizeMake(3.1/2.0, -0.1/2.0);
        CGFloat shadowBlurRadius = 12/2.0;
        self.layer.shadowColor = [shadow CGColor];
        self.layer.shadowOpacity = 0.73;
        self.layer.shadowOffset = shadowOffset;
        self.layer.shadowRadius = shadowBlurRadius;
        self.layer.shouldRasterize = YES;
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGFloat frameWidth = rect.size.width;//修改卡片大小
    CGFloat frameHeight = rect.size.height;///修改卡片大小
    CGFloat cornerRadius = 10;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* cardColor = self.cardColor;
    
    //显示文字
    UITextView *cardTextView = [[UITextView alloc] initWithFrame:CGRectMake(30,20,frameWidth-60,frameHeight-40)];
    cardTextView.backgroundColor = [UIColor clearColor];
    cardTextView.font = [UIFont fontWithName:@"Arial" size:30];
 //   self.cardText = @"demo";
    cardTextView.text = self.cardText;
    [self addSubview:cardTextView];
    
    NSLog(@"this demo!!!");
    
    //// card1
    {
        CGContextSaveGState(context);
        //        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
        CGContextBeginTransparencyLayer(context, NULL);
        
        //// Rectangle 4 Drawing
        UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, frameWidth, frameHeight) cornerRadius: cornerRadius];//修改卡片位置
        [cardColor setFill];
        [rectangle4Path fill];
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }
}
@end
