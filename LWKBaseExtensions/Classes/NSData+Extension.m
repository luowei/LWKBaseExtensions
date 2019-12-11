//
// Created by Luo Wei on 2017/5/11.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "NSData+Extension.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSData (Extension)

@end


@implementation NSData (Md5)

-(NSString *)base64Encode{
    return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

//以16进制的形式返回摘要
- (NSString *)md5 {
    const char *str = [self bytes];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG) self.length, result);

    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }

    return hash;
}

//返回16字节的摘要
- (NSData *)md5Data {
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5([self bytes], (CC_LONG) [self length], digest);
    NSData *md5Data = [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    return md5Data;
}

@end