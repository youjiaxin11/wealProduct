//
//  NSData+Gzip.h
//  taocaiku
//
//  Created by yf6190 on 8/13/14.
//  Copyright (c) 2014 Hangzhou Caizhu Network Technology Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Gzip)

- (NSData *) gzipInflate;
- (NSData *) gzipDeflate;

@end
