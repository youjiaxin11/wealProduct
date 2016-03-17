//
//  Word.h
//  weal
//
//  Created by sunzhong on 16/3/1.
//  Copyright © 2016年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject

//按钮1:形和义
@property NSString *wordId;// 单词id
@property NSString *word;//单词拼写，存这个单词
@property NSString *topic;//单词主题
@property NSArray *meaning;// 数组，存放多个版本的词义
@property NSArray *picture;// 数组

//按钮3:与单词有关的句子
@property NSArray *sentence;// 数组

//按钮4:与单词有关的课文段落（图片）
@property NSArray *dialogue;// 数组

//按钮5:与单词有关的动画（视频）
@property NSArray *video;// 数组，视频

//按钮6:与单词有关的绘本（图片）
@property NSArray *picturebook;// 数组
@property int tagid;
@end