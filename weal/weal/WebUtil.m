//
//  WebUtil.m
//  BaixiaoeBookV1
//
//  Created by sunzhong on 15/5/12.
//  Copyright (c) 2015年 sunzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebUtil.h"
#define tag_loading 10000 // 进度条的tag

@implementation WebUtil {
    ResponseCallback callback;
    UIImageView *imageView;
}

@synthesize url, param, serverData, requestType, control, isSolveFail, isBackup, isLoading;

#pragma mark 请求TCK服务器的构造方法
#pragma _partUrl 接口路径，只需要后面一截
#pragma _param 参数，多个参数用&隔开
- (id)initWithTck:(NSString*)_partUrl _param:(NSString*)_param _control:(BaseControl*)_control {
    self = [super init];
    self.url = [NSString stringWithFormat:@"%@%@", root_url, _partUrl];
    self.param = _param;
    self.requestType = type_tck;
    self.control = _control;
    return self;
}

#pragma mark 请求TCK服务器
#pragma _callback 回调函数的block
#pragma is_loading 如果为yes就表示要开启一个UIActivityIndicatorView
#pragma is_backup 是否需要备份数据(一般查询的数据需要备份，提交的数据不需要)
#pragma is_solveFail 调用接口失败时，是否内部处理错误
#pragma _frequency 调用接口的频率(单位：秒)，及时调接口，就传入0
- (void)requestTck:(ResponseCallback)_callback is_loading:(BOOL)is_loading is_backup:(BOOL)is_backup is_solveFail:(BOOL)is_solveFail _frequency:(int)_frequency {
    callback = _callback;
    self.isLoading = is_loading;
    self.isBackup = is_backup;
    self.isSolveFail = is_solveFail;
    
    [self requestTck1];
    return;
    
}

// 确定调用接口
- (void)requestTck1 {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [request setTimeoutInterval:request_time_out];
    [request setHTTPMethod:request_post];
    
    NSString* chars = @"&";
    NSString* _param = [NSString stringWithFormat:@"%@%@ak=%@", self.param, chars, param_ak];
    
    [request setHTTPBody:[_param dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    self.serverData = [NSMutableData data];
}


#pragma mark  代理方法1   接受到服务器的响应，服务器要传数据了，客户端做好接收准备
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
}

#pragma mark   代理方法2  接收服务器传输的数据，可能会多次执行  对每次传输的数据进行拼接,需要中转数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.serverData appendData:data];
}

#pragma mark   代理方法3  接收数据完成，做后续处理
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.requestType == type_tck) {
        NSString *result = [[NSString alloc] initWithData:self.serverData encoding:NSUTF8StringEncoding];
          NSLog(result);
      // [self createPrompt:result];
      //  NSData *data = [[result base64DecodedData] gzipInflate];
        NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *map =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (self.isSolveFail && ![[map objectForKey:@"status"] boolValue]) {
            [self createPrompt:map[@"message"]];
            return;
        }
        if (self.isBackup) {
          //  [DatabaseModel add:self.url param:self.param data:result];
        }
        if (nil != callback) {
            callback(map);
        } 
    }
    self.serverData = nil;
}



// 错误提示
- (void)createPrompt:(NSString*)msg {
    if (nil != self.control) {
        NSLog(@"不为空");
        [self.control prompt:msg];
    } else {
         NSLog(@"为空");
       // [ToolUtil alert:msg];
    }
}

@end
