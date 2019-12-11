//
// Created by Luo Wei on 2017/5/14.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "UIResponder+Extension.h"


@implementation UIResponder (Extension)

//打开指定url
- (void)openURLWithUrl:(NSURL *)url {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]) != nil) {
        if ([responder respondsToSelector:@selector(openURL:)]) {
            [responder performSelector:@selector(openURL:) withObject:url];
        }
    }
}

//打开指定urlString
- (void)openURLWithString:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]) != nil) {
        if ([responder respondsToSelector:@selector(openURL:)]) {
            [responder performSelector:@selector(openURL:) withObject:url];
        }
    }
}

//检查是否能打开指定urlString
- (BOOL)canOpenURLWithString:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]) != nil) {
        if ([responder respondsToSelector:@selector(canOpenURL:)]) {
            NSNumber *result = [responder performSelector:@selector(canOpenURL:) withObject:url];
            return result.boolValue;
        }
    }
    return NO;
}

@end