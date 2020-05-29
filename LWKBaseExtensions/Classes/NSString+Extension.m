//
// Created by Luo Wei on 2017/5/9.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSString (Extension)

@end

@implementation NSString (Addtion)

-(BOOL)isBlank{
    if([self length] == 0) { //string is empty or nil
        return YES;
    }
    return ![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length];
}

-(BOOL)isNotBlank{
    NSString *trimStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [trimStr length] > 0;
}

-(BOOL)containsChineseCharacters{
    NSRange range = [self rangeOfString:@"\\p{Han}" options:NSRegularExpressionSearch];
    return range.location != NSNotFound;
}

- (NSString *)subStringWithRegex:(NSString *)regexText matchIndex:(NSUInteger)index{
    __block NSString *text = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexText options:NSRegularExpressionCaseInsensitive error:nil];
    [regex enumerateMatchesInString:self options:0 range:NSMakeRange(0, [self length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        if(match && match.range.length >= index){
            text = [self substringWithRange:[match rangeAtIndex:index]];
        }
    }];
    return text;
}

- (NSArray<NSString *> *)matchStringWithRegex:(NSString *)regexText{
    __block NSMutableArray *matchArr = @[].mutableCopy;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([^&?]*?=[^&?]*)" options:NSRegularExpressionCaseInsensitive error:nil];
    [regex enumerateMatchesInString:self options:0 range:NSMakeRange(0, [self length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        if(match && match.range.length > 0){
            NSString *text = [self substringWithRange:[match rangeAtIndex:0]];
            [matchArr addObject:text];
        }
    }];
    return matchArr;
}


@end


@implementation NSString (Match)


- (BOOL)isMatchString:(NSString *)pattern {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        return NO;
    }
    NSTextCheckingResult *res = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return res != nil;
}

- (BOOL)isiTunesURL {
    return [self isMatchString:@"\\/\\/itunes\\.apple\\.com\\/"];
}

//是否是域名
- (BOOL)isDomain {
    return [self isMatchString:@"^([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,6}$"]
            || [self isMatchString:@"^(www.|[a-zA-Z].)[a-zA-Z0-9\\-\\.]+\\.(com|edu|gov|mil|net|org|biz|info|name|museum|us|ca|uk)(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\;\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"];
}

//是否是网址
- (BOOL)isHttpURL {
    return [self isMatchString:@"(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?"]
            || [self isMatchString:@"^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)?((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.[a-zA-Z]{2,4})(\\:[0-9]+)?(/[^/][a-zA-Z0-9\\.\\,\\?\\'\\\\/\\+&amp;%\\$#\\=~_\\-@]*)*$"]
            || [self isMatchString:@"^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"];
}

@end


@implementation NSString (Base64)

-(NSString *)base64Encode{
    NSData *encodeData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [encodeData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

-(NSString *)base64Decode{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return decodedString;
}

@end


@implementation NSString (Md5)

//以16进制的形式返回摘要
- (NSString *)md5 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    const char *str = [data bytes];
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
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes], (CC_LONG) [data length], digest);
    NSData *md5Data = [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    return md5Data;
}

@end


@implementation NSString (Chinese)

//汉字转拼音
- (NSString *)transformChinese {
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [self mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef) pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef) pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}

//转拼音
-(NSString *)chineseCharactersIntoPinyin {
    if (UIDevice.currentDevice.systemVersion.floatValue >= 9.0) {
        //此次转换时带声调
        NSString *pinyin = [self stringByApplyingTransform:NSStringTransformMandarinToLatin reverse:NO];
//        //此次转换可转换成不带声调的
//        pinyin = [self stringByApplyingTransform:NSStringTransformStripDiacritics reverse:NO];
          return pinyin;
    } else{
        return @"";
    }

}

@end

@implementation NSString (UnicodeText)

-(NSString *)unicodeString {
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i < [self length]; i++) {
        if(i > 0 && i < self.length){
            [str appendString:@"_"];
        }
        unichar _char = [self characterAtIndex:i];
        [str appendFormat:@"%x", [self characterAtIndex: i]];
    }
    return str;
}

//Unicode转UTF-8
- (NSString*) unicodetoUTF8 {
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];

    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:nil error:nil];

    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

//UTF-8转Unicode
- (NSString *)utf8ToUnicode {
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i < [self length]; i++) {
        if(i>0 && i < self.length - 1){
            [str appendString:@"_"];
        }
        unichar _char = [self characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0') {
            [str appendFormat:@"%@", [self substringWithRange:NSMakeRange(i, 1)]];
        } else if (_char >= 'a' && _char <= 'z') {
            [str appendFormat:@"%@", [self substringWithRange:NSMakeRange(i, 1)]];
        } else if (_char >= 'A' && _char <= 'Z') {
            [str appendFormat:@"%@", [self substringWithRange:NSMakeRange(i, 1)]];
        } else {
            //[str appendFormat:@"\\u%x", [self characterAtIndex: i]];
            [str appendFormat:@"%x", [self characterAtIndex: i]];
        }
    }
    return str;
}

@end

@implementation NSString (Sandbox)

+(NSString *)documentPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

-(BOOL)isExsitFilePath{
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}

@end

