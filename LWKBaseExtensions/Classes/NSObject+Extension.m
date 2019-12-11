//
// Created by luowei on 2017/2/28.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "NSObject+Extension.h"


@implementation NSObject (Extension)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];

    NSUInteger i = 1;
    for (id object in objects) {
        [invocation setArgument:(void *) &object atIndex:++i];
    }
    [invocation invoke];

    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}

- (id)performSelector:(SEL)aSelector withParameters:(void *)firstParameter, ... {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSUInteger length = [signature numberOfArguments];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];

    [invocation setArgument:&firstParameter atIndex:2];
    va_list arg_ptr;
    va_start(arg_ptr, firstParameter);
    for (NSUInteger i = 3; i < length; ++i) {
        void *parameter = va_arg(arg_ptr, void *);
        [invocation setArgument:&parameter atIndex:i];
    }
    va_end(arg_ptr);

    [invocation invoke];

    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}


- (id)performSelectorSafely:(SEL)aSelector {
    NSParameterAssert(aSelector != NULL);
    NSParameterAssert([self respondsToSelector:aSelector]);
    NSMethodSignature *methodSig = [self methodSignatureForSelector:aSelector];
    if (methodSig == nil) return nil;
    const char *retType = [methodSig methodReturnType];
    if (strcmp(retType, @encode(id)) == 0 || strcmp(retType, @encode(void)) == 0) {
        return [self performSelector:aSelector withParameters:nil];
    } else {
        NSLog(@"-[%@ performSelector:@selector(%@)] shouldn't be used. The selector doesn't return an object or void", NSStringFromClass([self class])	, NSStringFromSelector(aSelector));
        return nil;
    }
}

@end


@implementation NSObject (LWDevice)

-(void)vibrate {
    //参考：https://github.com/TUNER88/iOSSystemSoundsLibrary

    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleLight];
        [impactLight impactOccurred];
    }else{
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);

//    AudioServicesPlaySystemSound(1519); // Actuate `Peek` feedback (weak boom)
//    AudioServicesPlaySystemSound(1520); // Actuate `Pop` feedback (strong boom)
//    AudioServicesPlaySystemSound(1521); // Actuate `Nope` feedback (series of three weak booms)
        AudioServicesPlaySystemSound(1311);
    }
}

-(BOOL)is_iPad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

@end
