//
// Created by Luo Wei on 2017/5/9.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "UIView+Extensions.h"


@implementation UIView (Extensions)
@end


@implementation UIView (Snapshot)

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//截取 UIView 指定 rect 的图像
- (UIImage *)snapshotImageInRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:CGRectMake(-rect.origin.x, -rect.origin.y, self.bounds.size.width, self.bounds.size.height) afterScreenUpdates:YES];
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)snapshotImageRenderInContext {
    UIImage *snapShot = nil;
//    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        snapShot = UIGraphicsGetImageFromCurrentImageContext();
    }

    UIGraphicsEndImageContext();
    return snapShot;

}

@end



@implementation UIView (Copy)

-(id)copyView{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

@end


@implementation UIView (SuperRecurse)

- (UIViewController *)responderViewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *) responder;
}

//获得指class类型的父视图
- (id)superViewWithClass:(Class)clazz {
    UIResponder *responder = self;
    while (![responder isKindOfClass:clazz]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return responder;
}

@end

@implementation UIView (Resign)

- (UIView *)resignSubviewsFirstResponder {
    if ([self isFirstResponder]) {
        [self resignFirstResponder];
        return self;
    }
    for (UIView *subview in self.subviews) {
        UIView *result = [subview resignSubviewsFirstResponder];
        if (result) return result;
    }
    return nil;
}

-(UIView*)getSubviewsFirstResponder {
    UIView* requestedView = nil;
    for (UIView *view in self.subviews) {
        if (view.isFirstResponder) {
            return view;
        } else if (view.subviews.count > 0) {
            requestedView = [view getSubviewsFirstResponder];
        }
        if (requestedView != nil) {
            return requestedView;
        }
    }
    return nil;
}

@end

@implementation UIView (Rotation)

//递归的向子视图发送屏幕发生旋转了的消息
- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    for (UIView *v in self.subviews) {
        [v rotationToInterfaceOrientation:orientation];
    }
}

@end

@implementation UIView (NoScrollToTop)

- (void)subViewNOScrollToTopExcludeClass:(Class)clazz {

    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *) v;
            scrollView.scrollsToTop = clazz == nil ? NO : [v isKindOfClass:clazz];
        }
        [v subViewNOScrollToTopExcludeClass:clazz];
    }
}

@end

@implementation UIView (updateAppearance)

- (void)updateAppearance {

    for (UIView *v in self.subviews) {
        [v updateAppearance];
    }

}

//判断是否是深色模式
-(BOOL)isDarkStyle {
    if(@available(iOS 12.0,*)){
        if(self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
            return YES;
        }
    }
    return NO;
}

@end

@implementation UIView (CallCycle)

-(void)applicationDidEnterBackground{
//    for (UIView *v in self.subviews) {
//        [v applicationDidEnterBackground];
//    }
}
-(void)applicationDidBecomeActive{
//    for (UIView *v in self.subviews) {
//        [v applicationDidBecomeActive];
//    }
}
-(void)applicationWillTerminate{

}

-(void)applicationWillResignActive{

}
-(void)applicationWillEnterForeground{

}

-(void)willAppear{
    for (UIView *v in self.subviews) {
        [v willAppear];
    }
}
-(void)willDisappear{
    for (UIView *v in self.subviews) {
        [v willDisappear];
    }
}

@end

@implementation UIView (ScaleSize)

- (CGSize)scaleSize{
    CGFloat  scale = [UIScreen mainScreen].scale;
    return CGSizeMake(self.bounds.size.width * scale, self.bounds.size.height * scale);
}

-(CGSize)size{
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

-(CGPoint)origin{
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

@end


@implementation UIView (LWAnimation)

- (void)shakeWithCompletionBlock:(nullable void (^)(void))completionBlock {
    [self shakeViewWithOffest:10.0f completionBlock:completionBlock];
}

- (void)shakeViewWithOffest:(CGFloat)offset completionBlock:(nullable void (^)(void))completionBlock{
    [CATransaction begin];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    [animation setDuration:0.05];
    [animation setRepeatCount:6];
    [animation setAutoreverses:YES];
    [animation setFromValue:@([self center].x-offset)];
    [animation setToValue:@([self center].x+offset)];

    if(completionBlock){
        CATransaction.completionBlock = completionBlock;
    }

    [self.layer addAnimation:animation forKey:@"shakeViewWithOffest"];
    [CATransaction commit];
}


- (void)shakeScreenWithCompletionBlock:(nullable void (^)(void))completionBlock {
//    AudioServicesPlaySystemSound(1519); // Actuate `Peek` feedback (weak boom)
    //Shake screen
    CGFloat t = 5.0;
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t, t);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, -t);

    self.transform = translateLeft;

    [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        self.transform = translateRight;
    }                completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                        self.transform = CGAffineTransformIdentity;
                    }
                             completion:^(BOOL finish){
                if(finish && completionBlock){
                    completionBlock();
                }
            }];
        }
    }];
}

//放大再缩小
-(void)zoomInOutWithCompletionBlock:(nullable void (^)(void))completionBlock{
    [CATransaction begin];
    //放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = @0.7F;   //初始伸缩倍数
    animation.toValue = @1.3F;     //结束伸缩倍数

    if(completionBlock){
        CATransaction.completionBlock = completionBlock;
    }

    [[self layer] addAnimation:animation forKey:@"zoomInOut"];
    [CATransaction commit];
}

-(void)upAndDownWithCompletionBlock:(nullable void (^)(void))completionBlock{
    [CATransaction begin];
    //向上移动
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.12;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = YES;
    animation.fromValue = @0.0F;   //初始伸缩倍数
    animation.toValue = @(-10);     //结束伸缩倍数

    if(completionBlock){
        CATransaction.completionBlock = completionBlock;
    }

    [[self layer] addAnimation:animation forKey:@"upAndDown"];
    [CATransaction commit];
}





@end