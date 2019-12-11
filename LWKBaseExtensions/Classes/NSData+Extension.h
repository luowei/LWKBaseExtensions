//
// Created by Luo Wei on 2017/5/11.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Extension)

@end


@interface NSData (Md5)

-(NSString *)base64Encode;

- (NSString *)md5;

//返回16字节的摘要
- (NSData *)md5Data;

@end