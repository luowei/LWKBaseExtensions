//
// Created by Luo Wei on 2017/5/11.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "NSArray+Extension.h"


@implementation NSArray (Extension)

- (BOOL)containsString:(NSString *)string {

    BOOL isContain = NO;
    for (NSString *str in self) {

        if ([str rangeOfString:string].location != NSNotFound) {
            isContain = YES;
            break;
        }
    }
    return isContain;
}

-(BOOL)containsStringItem:(NSString*)string {
    for (NSString *str in self) {
        if ([str isEqualToString:string])
            return YES;
    }
    return NO;
}

-(NSUInteger)indexOfStringObject:(NSString *)string {
    for(NSString *str in self){
        if([str isEqualToString:string]){
            return [self indexOfObject:str];
        }
    }
    return INT_MAX;
}

@end