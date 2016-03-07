
//
//  UploadFile.h
//  weal
//
//  Created by sunzhong on 16/3/3.
//  Copyright © 2016年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UploadFile : NSObject
#pragma mark - 上传文件
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data;
@end
