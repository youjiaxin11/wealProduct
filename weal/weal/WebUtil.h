//
//  WebUtil.h
//  BaixiaoeBookV1
//
//  Created by sunzhong on 15/5/12.
//  Copyright (c) 2015年 sunzhong. All rights reserved.
//  访问网络的工具类

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "Base64.h"
#import "NSData+Gzip.h"
#import "BaseControl.h"


#define request_post @"POST"
#define request_get @"GET"
#define request_time_out 18
#define param_ak @"e10adc3949ba59abbe56e057f20f883e"
#define net_err_msg @"找不到可用的网络连接>.<"
#define load_fail_msg @"很抱歉，网络不给力，加载数据失败了>.<"

//#define root_url @"http://192.168.0.114:8080/tck_ios_server"
#define root_url @"http://192.168.0.107:8088/iqasweb"


enum RequestType {
    type_tck = 1,// 请求TCK服务器接口
    type_other = 2,// 请求其他服务器接口
    type_upload = 3,// 上传文件
    type_image = 4// 下载图片
};

@interface WebUtil : NSObject

@property NSString *url;
@property NSString *param;
@property NSMutableData *serverData;
@property enum RequestType requestType;
@property BaseControl *control;
@property BOOL isSolveFail;
@property BOOL isBackup;
@property BOOL isLoading;


#pragma mark 请求TCK服务器的构造方法
#pragma _partUrl 接口路径，只需要后面一截
#pragma _param 参数，多个参数用&隔开
#pragma _control 控制器的实例
- (id)initWithTck:(NSString*)_partUrl _param:(NSString*)_param _control:(BaseControl*)_control;


#pragma mark 请求TCK服务器
#pragma _callback 回调函数的block
#pragma is_loading 如果为yes就表示要开启一个UIActivityIndicatorView
#pragma is_backup 是否需要备份数据(一般查询的数据需要备份，提交的数据不需要)
#pragma is_solveFail 调用接口失败时，是否内部处理错误
#pragma _frequency 调用接口的频率(单位：秒)，及时调接口，就传入0
- (void)requestTck:(ResponseCallback)_callback is_loading:(BOOL)is_loading is_backup:(BOOL)is_backup is_solveFail:(BOOL)is_solveFail _frequency:(int)_frequency;


@end

