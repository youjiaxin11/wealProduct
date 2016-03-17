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
@synthesize userWordGuide, thisThemeKey, thisThemeValue, secondeThemeKey, secondeTheme, secondeThemeAllWords, secondeThemeAllInfo,imageViewlineshow,imageViewlineshow1,fromnextpage;

Word* word1;
Word* wordall;
NSMutableArray *topic1s;//1级主题的单词
NSMutableArray *topic2s;//2级主题的单词
NSMutableArray *topic3s;//3级主题的单词
NSMutableArray *topic22s;//同一2级主题的单词
NSMutableArray *topic33s;//同一3级主题的单词
NSMutableArray *arraybytopic;
int index2;
int count1=0;//同一主题单词个数
int count2;//区分不同级单词
int counttopic1; //一级主题词个数
int counttopic2;
int counttopic3;
NSString  * string1;
NSString  * string2;
unichar c1;
NSString  * string21;
NSString  * string31;
NSString  * string22;
NSString  * string32;
int mm;
int countsecond=0;//点击二级主题次数
int tag1=1;
- (void)viewDidLoad
{   NSLog(@"from=%d",fromnextpage);
    [super viewDidLoad];
    //必须先初始化才能添加元素
    imageViewlineshow=[[UIImageView alloc]initWithFrame:self.view.frame]; imageViewlineshow1=[[UIImageView alloc]initWithFrame:self.view.frame];
    secondeThemeKey = [[NSMutableArray alloc]init];
    secondeTheme = [[NSMutableArray alloc]init];
    secondeThemeAllWords = [[NSMutableArray alloc]init];
    secondeThemeAllInfo = [[NSMutableArray alloc]init];
    topic1s= [[NSMutableArray alloc]init];
    topic2s= [[NSMutableArray alloc]init];
    topic3s= [[NSMutableArray alloc]init];
    topic22s= [[NSMutableArray alloc]init];
    topic33s= [[NSMutableArray alloc]init];
    arraybytopic=[[NSMutableArray alloc]init];
    //设置按钮标题＝大主题的值
    // [star1 setTitle: thisThemeValue forState: UIControlStateNormal];
    //star1.tag=1;
    word1=[[Word alloc]init];
    wordall=[[Word alloc]init];
    Word *eachWord = [[Word alloc]init];
    eachWord.topic = thisThemeKey;
    eachWord.word = thisThemeValue;
    [secondeThemeAllInfo addObject:eachWord];
    [self starappear];
}


//从后台得到大主题下的所有小主题
- (void)getSecondTheme{
    NSError *error;
    //加载一个NSURL对象
    NSString *totalUrl = [NSString stringWithFormat:@"http://172.19.203.8:8080/iqasweb/mobile/ios/theme/findChilThemes.html?themeNumber=%@",thisThemeKey];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:totalUrl]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    if(response != NULL){
        NSDictionary *chilThemesDictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        //取出result的值
        NSDictionary *result = [chilThemesDictionary objectForKey:@"result"];
        //取出data的值
        NSArray *data = [result objectForKey:@"data"];
        
        //取出第一个小主题的所有值
        NSDictionary *content1 = [data objectAtIndex:0];
        
        for (int i = 0; i < [data count] ; i++) {
            Word* eachWord = [[Word alloc]init];
            //得到小主题的所有值
            NSDictionary *content = [data objectAtIndex:i];
            //取出第i个小主题下的number的值
            NSString *content_number = [content objectForKey:@"number"];
            NSLog(@"content_number%d:%@", i, content_number );
            eachWord.topic = [content_number stringByAppendingString:@"-"];
            //取出第i个小主题的值
            NSString *content_english = [content objectForKey:@"english"];
            NSLog(@"content_english%d:%@", i, content_english );
            eachWord.word = content_english;
            //保存
            [secondeTheme addObject:eachWord];
            NSLog(@"secondeTheme:%@", secondeTheme);
            
        }
        NSLog(@"secondeTheme:%@", secondeTheme);
        
        //打印
        //取出第1个小主题下的number的值
        NSString *content1_number = [content1 objectForKey:@"number"];
        NSLog(@"content1_number:%@", content1_number );
        
        //取出第一个小主题下的content的值
        NSString *content1_content = [content1 objectForKey:@"content"];
        NSLog(@"content1_content:%@", content1_content );
        
        //取出第一个小主题下的english的值
        NSString *content1_english = [content1 objectForKey:@"english"];
        NSLog(@"content1_english:%@", content1_english );
        
        //取出第一个小主题下的picturePath的值
        NSString *content1_picturePath = [content1 objectForKey:@"picturePath"];
        NSString *totalImageURL = [NSString stringWithFormat:@"http://172.19.203.8:8080/iqasweb/%@",content1_picturePath];
        UIImage *content1_image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:totalImageURL]]];
        
    }else{
        NSLog(@"response is null");
    }
    
}

//从后台得到小主题下的所有单词
- (void)getAllWordsOfSecondTheme:(int) secondThemeIndex{
    NSLog(@"开始第二个函数啦");
    
    NSError *error;
    //加载一个NSURL对象
    //    NSString *totalUrl = [NSString stringWithFormat:@"http://172.19.203.8:8080/iqasweb/mobile/ios/theme/findWordsByTheme.html?themeNumber=%@&userName=%@&password=%@",[secondeTheme objectAtIndex:secondThemeIndex], userWordGuide.loginName, userWordGuide.password];
    
    NSLog(@"secondThemeIndex  ==  %d",secondThemeIndex);
    Word *thisTheme = [secondeThemeAllInfo objectAtIndex:secondThemeIndex];
    NSLog(@"secondeThemeKey  ==  %@", thisTheme.topic);
    NSString *myTheme = [thisTheme.topic substringToIndex:thisTheme.topic.length-1];
    NSString *totalUrl = [NSString stringWithFormat:@"http://172.19.203.8:8080/iqasweb/mobile/ios/theme/findWordsByTheme.html?themeNumber=%@&userName=%@&password=%@",myTheme, @"abc", @"123"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:totalUrl]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    if(response != NULL){
        NSDictionary *chilThemesDictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        //取出result的值
        NSLog(@"%@",chilThemesDictionary);
        NSDictionary *result = [chilThemesDictionary objectForKey:@"result"];
        NSLog(@"%@",result);
        //取出data的值
        NSInteger WG_count = [result objectForKey:@"count"];
        NSLog(@"%ld",(long)WG_count);;
        NSArray *data = [result objectForKey:@"data"];
        //        //取出第一个小主题的所有值
        //        NSDictionary *content1 = [data objectAtIndex:0];
        //        //取出第一个小主题下的content的值
        //        NSString *content1_content = [content1 objectForKey:@"content"];
        
        for (int i = 0; i < data.count ; i++) {
            Word *eachWord = [[Word alloc]init];
            //得到小主题的所有值
            NSDictionary *content = [data objectAtIndex:i];
            //取出第i个小主题下的单词的word的值
            NSString *content_word = [content objectForKey:@"word"];
            NSLog(@"content_word%d:%@", i, content_word );
            
            //取出第i个小主题下的单词的number的值
            NSString *content_theme = [content objectForKey:@"theme"];
            NSLog(@"content_theme%d:%@", i, content_theme );
            
            eachWord.topic = content_theme;
            eachWord.word = content_word;
            
            //保存
            [secondeThemeAllWords addObject:eachWord];
            
        }
        NSLog(@"data.count:%d", data.count);
        NSLog(@"secondeThemeAllWords:%@", secondeThemeAllWords);
        
    }else{
        NSLog(@"response is null");
    }
}


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

- (void)nextpage:(NSString*)wordSelected{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WordLearning *nextPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"WordLearning"];
    nextPage.userWordLearning = userWordGuide;
    nextPage.thisWord = wordSelected;
    nextPage.thisThemeKey1 = thisThemeKey;//把主题图片对应的编码传递给下一页
    nextPage.thisThemeValue1 = thisThemeValue;//把主题传递给下一页
    [nextPage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextPage animated:YES completion:nil];
}

-(void)starappear{
    
    counttopic1=0;
    tag1=1;
    countsecond=0;
    NSLog(@"secondeThemeAllInfo1%@", secondeThemeAllInfo);
    //获取所有小主题
    [self getSecondTheme];
    //把所有小主题放入整个数组中
    for (int i = 0; i < secondeTheme.count; i++) {
        [secondeThemeAllInfo addObject:[secondeTheme objectAtIndex:i]];
    }
    NSLog(@"secondeThemeAllInfo2%@", secondeThemeAllInfo);
    
    //获取所有小主题下的所有单词
    int secondeThemeSize = secondeThemeAllInfo.count;
    for (int i = 1; i < secondeThemeSize; i++) {
        [self getAllWordsOfSecondTheme: i];
    }
    //    [self getAllWordsOfSecondTheme: btnn.tag-2];
    //把所有小主题下的所有单词合并到这个整个数组中
    NSArray *allInfoArray = [secondeThemeAllInfo arrayByAddingObjectsFromArray:secondeThemeAllWords];
    NSLog(@"allInfoArray%@", allInfoArray);
    NSLog(@"count=%d",[allInfoArray count]);
    Word* wordss=[allInfoArray objectAtIndex:0];
    NSLog(@"aaa=%@",wordss.topic);
    counttopic1=counttopic2=counttopic3=0;
    for(int m=0;m<[allInfoArray count];m++)
    {  word1=[allInfoArray objectAtIndex:m];
        NSLog(@"word1.topic=%@",word1.topic);
        //  index2=index1+1;
        // string1=[NSString stringWithFormat:@"%d",index2];
        string1=@"-";
        //  NSLog(@"%@",string1);
        count2=0;
        for(int x=0;x<word1.topic.length;x++)
        { c1=[word1.topic characterAtIndex:x];
            string2=[NSString stringWithFormat:@"%c",c1];
            if([string2 isEqualToString:string1]) count2++;
            //  NSLog(@"count2=%d",count2);
        }
        if(count2==1){
            counttopic1++;
            [topic1s addObject:word1];
            NSLog(@"topic1s=%@",topic1s);
        }
        else if(count2==3){
            [topic2s addObject:word1];
        }
        else if(count2==2){
            [topic3s addObject:word1];
            NSLog(@"topic3s=%@",topic3s);
        }
        
    }
    NSLog(@"topic1count=%d",[topic1s count]);
    NSLog(@"topic2count=%d",[topic2s count]);
    NSLog(@"topic3count=%d",[topic3s count]);
    for(int i=0;i<[topic1s count];i++)
    {  Word* wordtopic1s=[topic1s objectAtIndex:i];
        wordall=[topic1s objectAtIndex:i];
        if(wordall.word==wordtopic1s.word)
        {wordall.tagid=tag1++;
        [arraybytopic addObject: wordall ];
        }
    }
    for(int i=0;i<[topic2s count];i++)
    {  Word* wordtopic2s=[topic2s objectAtIndex:i];
        wordall=[topic2s objectAtIndex:i];
        if(wordall.word==wordtopic2s.word)
        {wordall.tagid=tag1++;
        [arraybytopic addObject: wordall ];
        }
    }
    for(int i=0;i<[topic3s count];i++)
    {  Word* wordtopic3s=[topic3s objectAtIndex:i];
        wordall=[topic3s objectAtIndex:i];
        if(wordall.word==wordtopic3s.word)
        { wordall.tagid=tag1++;
        [arraybytopic addObject: wordall];
        }
    }
    for(int i=0;i<[arraybytopic count];i++)
    { Word* wordtest=[arraybytopic objectAtIndex:i];
        NSLog(@"arrayword=%@",wordtest.word);
        NSLog(@"arrayid=%d",wordtest.tagid);
    }
    NSLog(@"counttopic1=%d",counttopic1);
    [self topic1];
    // NSLog(@"%@",string1);
}      // NSLog(@"%@",string2);

-(void)topic1{
    
    for(int k=0;k<counttopic1;k++)
    {   Word* wordt1=[topic1s objectAtIndex:k];
        CGRect btn1Frame = CGRectMake(100, 400.0+ k*150, 150.0, 150.0);
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn1.frame =btn1Frame;
        for(int i=0;i<[arraybytopic count];i++)
        { Word* wordtt1=[arraybytopic objectAtIndex:i];
            if(wordtt1.word==wordt1.word)
            {btn1.tag=wordtt1.tagid;
                NSLog(@"wordtt1.tag=%d",btn1.tag);}
        }
        // NSLog(@"%d",btn1.tag);
        //NSString* fileName = [@"star1" stringByAppendingString:[NSString stringWithFormat: @"%d", 1]];
        // NSString* fileName2 = [fileName stringByAppendingString:@".png"];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"star1"] forState:UIControlStateNormal];
                NSLog(@"bbb=%@",wordt1.topic);
        [btn1 setTitle:wordt1.word forState:UIControlStateNormal];
        [btn1 setFont:[UIFont systemFontOfSize:20]];
        btn1.titleLabel.lineBreakMode=0;
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
    }
}
-(void)topic2:(UIButton*)btn indexx:(int)index1
{
    Word* wordt1=[topic1s objectAtIndex:index1];
    string21=wordt1.topic;
    NSLog(@"string21=%@",string21);
    counttopic2=0;
    for(int m=0;m<[topic2s count];m++)
    {  Word* wordt2=[topic2s objectAtIndex:m];
        NSLog(@"aaa=%@",wordt2.topic);
        string22=[wordt2.topic substringToIndex:4];
        NSLog(@"string22=%@",string22);
        if([string22 isEqualToString:string21])
        { counttopic2++;
            [topic22s addObject:wordt2];
        }
    }
    NSLog(@"counttopic2=%d",counttopic2);
    for(int k=0;k<counttopic2;k++)
    {  CGRect btn1Frame = CGRectMake(200+150*(index1+1), 200.0+(k-counttopic1)*150, 100.0, 100.0);
        UIButton *btn1= [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn1.frame =btn1Frame;
        Word* wordt2=[topic22s objectAtIndex:k];
        for(int i=0;i<[arraybytopic count];i++)
        { Word* wordtt2=[arraybytopic objectAtIndex:i];
            if(wordtt2.word==wordt2.word)
            {btn1.tag=wordtt2.tagid;
            NSLog(@"wordtt2.tag=%d",btn1.tag);
            }
        }
        NSLog(@"tag2=%d",btn1.tag);
        //NSString* fileName = [@"star1" stringByAppendingString:[NSString stringWithFormat: @"%d", 1]];
        // NSString* fileName2 = [fileName stringByAppendingString:@".png"];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"star2"] forState:UIControlStateNormal];
                [btn1 setTitle:wordt2.word forState:UIControlStateNormal];
        [btn1 setFont:[UIFont systemFontOfSize:20]];
        btn1.titleLabel.lineBreakMode=0;
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
        [self drawline:btn btn2:btn1];
    }
}


-(void)topic3:(UIButton*)btn indexx:(int)index2
{
    Word* wordt2=[topic2s objectAtIndex:index2];
    string31=[wordt2.topic substringToIndex:7];
    NSLog(@"string31=%@",string31);
    counttopic3=0;
    for(int m=0;m<[topic3s count];m++)
    {  Word* wordt3=[topic3s objectAtIndex:m];
        string32=wordt3.topic;
        NSLog(@"string32=%@",string32);
        if([string32 isEqualToString:string31])
        {   counttopic3++;
            [topic33s addObject:wordt3];
        }
    }
    NSLog(@"counttopic3=%d",counttopic3);
    for(int k=0;k<counttopic3;k++)
    {
        CGRect btn1Frame = CGRectMake(100+300+150*(index2+1),10+ k*(700/counttopic3),50 ,50);
        UIButton *btn1= [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn1.frame =btn1Frame;
         Word* wordt3=[topic33s objectAtIndex:k];
        for(int i=0;i<[arraybytopic count];i++)
        { Word* wordtt3=[arraybytopic objectAtIndex:i];
            if(wordtt3.word==wordt3.word) {btn1.tag=wordtt3.tagid;
                NSLog(@"wordtt3.tag=%d",btn1.tag);}
        }        //NSString* fileName = [@"star1" stringByAppendingString:[NSString stringWithFormat: @"%d", 1]];
        // NSString* fileName2 = [fileName stringByAppendingString:@".png"];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"star5"] forState:UIControlStateNormal];
       
        [btn1 setTitle:wordt3.word forState:UIControlStateNormal];
        NSLog(@"wordt3.word=%@",wordt3.word);
        [btn1 setFont:[UIFont systemFontOfSize:15]];
        btn1.titleLabel.lineBreakMode=0;
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
        
        [self drawline1:btn btn2:btn1];
        
    }
}
-(void)btnPressed:(id)sender{
    UIButton* btn = (UIButton*)sender;
    NSLog(@"tagzzz=%d",btn.tag);
    
    if(btn.tag<=[topic1s count]) [self topic2:btn indexx:btn.tag-1];
    else if([topic1s count]+1<=btn.tag&&btn.tag<=[topic1s count]+[topic2s count])
    {   [self deleteLine];
        countsecond++;
        NSLog(@"countsecond=%d",countsecond);
        if(countsecond>1)
        {   //[self deleteLine];
            NSLog(@"topic1scountz=%d",[topic1s count]);
            NSLog(@"topic2scountz=%d",[topic2s count]);
            NSLog(@"topic3scountz=%d",[topic3s count]);
            for(int k=[topic1s count]+[topic2s count]+1;k<[topic1s count]+[topic2s count]+1+[topic3s count];k++)
            {  UIButton* hbutton=[self.view viewWithTag:k];
                NSLog(@"title=%@",hbutton.titleLabel.text);
                NSLog(@"tagkkk=%d",hbutton.tag);
                [hbutton removeFromSuperview];
            }
        }
        [self topic3:btn indexx:btn.tag-[topic1s count]-1];
    }
    else if(btn.tag>=[topic1s count]+[topic2s count]+1)
    {
        mm=btn.tag-[topic1s count]-[topic2s count]-1;
        NSLog(@"mm=%d",mm);
        Word* wordn=[topic3s objectAtIndex:mm];
        NSString* nextword=wordn.word;
        NSLog(@"word=%@",nextword);
        [self nextpage:nextword];
    }
}

-(void)drawline:(UIButton *)btn btn2:(UIButton *)btn1 {
    // imageViewlineshow=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:imageViewlineshow];
    self.view.backgroundColor=[UIColor whiteColor];
    UIGraphicsBeginImageContext(imageViewlineshow.frame.size);
    [imageViewlineshow.image drawInRect:CGRectMake(0, 0, imageViewlineshow.frame.size.width, imageViewlineshow.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 3, 3.0, 3.0, 3.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),btn.frame.origin.x+75,btn.frame.origin.y+75);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), btn1.frame.origin.x, btn1.frame.origin.y+50);
    //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageViewlineshow.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)drawline1:(UIButton *)btn btn2:(UIButton *)btn1{
    //imageViewlineshow1=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:imageViewlineshow1];
    self.view.backgroundColor=[UIColor whiteColor];
    UIGraphicsBeginImageContext(imageViewlineshow1.frame.size);
    [imageViewlineshow1.image drawInRect:CGRectMake(0, 0, imageViewlineshow1.frame.size.width, imageViewlineshow1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 3, 3.0, 3.0, 3.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),btn.frame.origin.x+50,btn.frame.origin.y+25);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), btn1.frame.origin.x+20, btn1.frame.origin.y+25);
    //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageViewlineshow1.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
- (void)deleteLine {
    
    [self.view addSubview:imageViewlineshow1];
    CGContextClearRect(UIGraphicsGetCurrentContext(),self.view.frame);
    [imageViewlineshow1 removeFromSuperview];
    
}

@end