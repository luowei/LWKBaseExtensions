//
// Created by Luo Wei on 2017/5/11.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

- (BOOL)containsString:(NSString *)string;
-(BOOL)containsStringItem:(NSString*)string;

-(NSUInteger)indexOfStringObject:(NSString *)string;

@end