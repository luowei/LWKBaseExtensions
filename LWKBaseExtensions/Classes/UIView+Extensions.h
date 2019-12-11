//
// Created by Luo Wei on 2017/5/9.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)



@end


@interface UIView (SnapShot)

- (UIImage *)snapshotImage;
//截取 UIView 指定 rect 的图像
- (UIImage *)snapshotImageInRect:(CGRect)rect;

- (UIImage *)snapshotImageRenderInContext;

@end


@interface UIView (Copy)

-(id)copyView;

@end

@interface UIView (SuperRecurse)

//获得一个View的响应ViewController
- (UIViewController *)responderViewController;

//获得指class类型的父视图
- (id)superViewWithClass:(Class)clazz;

@end


@interface UIView (Resign)

- (UIView *)resignSubviewsFirstResponder;

-(UIView*)getSubviewsFirstResponder;

@end

@interface UIView (Rotation)

//用于接收屏幕发生旋转消息
- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end


@interface UIView (NoScrollToTop)

- (void)subViewNOScrollToTopExcludeClass:(Class)clazz;

@end


//更新外观
@interface UIView (updateAppearance)
- (void)updateAppearance;
@end

@interface UIView (CallCycle)

-(void)applicationWillResignActive;
-(void)applicationWillEnterForeground;
-(void)applicationDidEnterBackground;
-(void)applicationDidBecomeActive;
-(void)applicationWillTerminate;


-(void)willAppear;
-(void)willDisappear;

@end


@interface UIView (ScaleSize)
- (CGSize)scaleSize;
-(CGSize)size;
-(CGPoint)origin;
@end


#import <AudioToolbox/AudioServices.h>
@interface UIView (LWAnimation)/*<CAAnimationDelegate>*/

-(void)shakeWithCompletionBlock:(nullable void (^)(void))completionBlock;
- (void)shakeViewWithOffest:(CGFloat)offset completionBlock:(nullable void (^)(void))completionBlock;
-(void)shakeScreenWithCompletionBlock:(nullable void (^)(void))completionBlock;
-(void)zoomInOutWithCompletionBlock:(nullable void (^)(void))completionBlock;
-(void)upAndDownWithCompletionBlock:(nullable void (^)(void))completionBlock;

@end
