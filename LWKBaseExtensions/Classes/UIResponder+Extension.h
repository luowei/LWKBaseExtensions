//
// Created by Luo Wei on 2017/5/14.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Extension)

//打开指定url
- (void)openURLWithUrl:(NSURL *)url;
//打开指定urlString
- (void)openURLWithString:(NSString *)urlString;

//检查是否能打开指定urlString
- (BOOL)canOpenURLWithString:(NSString *)urlString;

@end