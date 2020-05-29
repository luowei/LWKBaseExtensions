//
// Created by Luo Wei on 2017/5/9.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

@end

@interface NSString (Addtion)

-(BOOL)isBlank;

-(BOOL)isNotBlank;

-(BOOL)containsChineseCharacters;

- (NSString *)subStringWithRegex:(NSString *)regexText matchIndex:(NSUInteger)index;

- (NSArray<NSString *> *)matchStringWithRegex:(NSString *)regexText;

@end


@interface NSString(Match)

- (BOOL)isMatchString:(NSString *)pattern;

- (BOOL)isiTunesURL;

- (BOOL)isDomain;

- (BOOL)isHttpURL;

@end


@interface NSString (Base64)

-(NSString *)base64Encode;

-(NSString *)base64Decode;

@end


@interface NSString (Md5)

//以16进制的形式返回摘要
- (NSString *)md5 ;

//返回16字节的摘要
- (NSData *)md5Data;

@end


@interface NSString (Chinese)

//汉字转拼音
- (NSString *)transformChinese;

//转拼音
-(NSString *)chineseCharactersIntoPinyin;

@end

@interface NSString (UnicodeText)

-(NSString *)unicodeString;

//Unicode转UTF-8
- (NSString*) unicodetoUTF8;

//UTF-8转Unicode
- (NSString *)utf8ToUnicode;

@end


@interface NSString (Sandbox)

+(NSString *)documentPath;
-(BOOL)isExsitFilePath;

@end

