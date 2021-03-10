//
// Created by luowei on 2017/2/28.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface NSObject (Extension)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;
- (id)performSelector:(SEL)aSelector withParameters:(void *)firstParameter, ...;
-(id) performSelectorSafely:(SEL)aSelector;

@end


@interface NSObject (LWDevice)

//振动
-(void)vibrate;

-(BOOL)is_iPad;

@end
