//
// Created by Luo Wei on 2017/5/14.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <objc/runtime.h>
#import "UIImage+Extension.h"


@implementation UIImage (Extension)

+(UIImage *)imageNamed:(NSString *)imageName inBundleNamed:(NSString *)bundleName {
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]];
    UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

@end

@implementation UIImage (Color)

/**
* 给指定的图片染色
*/
- (UIImage *)imageWithOverlayColor:(UIColor *)color {

//    if (UIGraphicsBeginImageContextWithOptions) {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
//    }
//    else {
//        UIGraphicsBeginImageContext(self.size);
//    }

    [self drawInRect:CGRectMake(0.0f, 0.0f, self.size.width, self.size.height)];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);

    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, self.size.width, self.size.height));

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);

    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];

    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return tintedImage;
}

//根据颜色与矩形区生成一张图片
+ (UIImage *)imageFromColor:(UIColor *)color withRect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//根据颜色与Size生成一张图片
+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size {
    CGFloat scale = [UIScreen mainScreen].scale;
    //UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//根据View获得一张图片
+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//把字符串依据指定的字体属性及大小转换成图片
+ (UIImage *)imageFromString:(NSString *)string attributes:(NSDictionary *)attributes size:(CGSize)size {
    CGFloat scale = [UIScreen mainScreen].scale;
    //UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [string drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end


@implementation UIImage (Cut)

//根据指定矩形区,剪裁图片
- (UIImage *)cutImageWithRect:(CGRect)cutRect {
    CGImageRef cutImageRef = CGImageCreateWithImageInRect(self.CGImage, cutRect);
    UIImage *cutImage = [UIImage imageWithCGImage:cutImageRef];
    return cutImage;
}

//在指定大小的绘图区域内中央,将img2合成到img1上
+ (UIImage *)combineBGImage:(UIImage *)bgImg withImage:(UIImage *)img
                    andSize:(CGSize)imgSize inSize:(CGSize)size {

    //UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, img.scale);

    CGPoint bgImgOrigin = CGPointMake(0, 0);
    [bgImg drawAtPoint:bgImgOrigin];
    //[bgImg drawInRect:<#(CGRect)rect#>];

    CGPoint imgOrigin = CGPointMake((size.width-imgSize.width)/2, (size.height-imgSize.height)/2);
    [img drawAtPoint:imgOrigin];

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;

}

//在指定大小的绘图区域内,将img2合成到img1上
+ (UIImage *)addImageToImage:(UIImage *)img withImage2:(UIImage *)img2
                     andRect:(CGRect)cropRect withImageSize:(CGSize)size {

    UIGraphicsBeginImageContext(size);

    CGPoint pointImg1 = CGPointMake(0, 0);
    [img drawAtPoint:pointImg1];

    CGPoint pointImg2 = cropRect.origin;
    [img2 drawAtPoint:pointImg2];

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;

}

//裁切圆角
-(UIImage *)withRoundedCorners:(CGFloat)radius {
    CGFloat maxRadius = MIN(self.size.width, self.size.height)/2;
    CGFloat cornerRadius = radius > 0 && radius <= maxRadius ? radius : maxRadius;
    UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.mainScreen.scale );
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [bezierPath addClip];
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//把一张图片缩放到指定大小
- (UIImage *)imageToscaledSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//把一张图片按长宽等比例缩放到适应指定大小
- (UIImage *)scaleToSizeKeepAspect:(CGSize)size {
    UIGraphicsBeginImageContext(size);

    CGFloat ws = size.width / self.size.width;
    CGFloat hs = size.height / self.size.height;

    if (ws > hs) {
        ws = hs / ws;
        hs = 1.0;
    } else {
        hs = ws / hs;
        ws = 1.0;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGContextDrawImage(context, CGRectMake(size.width / 2 - (size.width * ws) / 2,
            size.height / 2 - (size.height * hs) / 2, size.width * ws,
            size.height * hs), self.CGImage);

    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return scaledImage;
}

//把一张图片缩放到微信可接收的200x200的缩略图
-(UIImage *)scaleToWXThumbnailSizeKeepAspect:(CGSize)size {
    if(self.size.width < size.width && self.size.height < size.height){
        return self;
    }
    return [self scaleToSizeKeepAspect:size];
}

//把图片按指定比例缩放
- (UIImage *)imageToScale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//截取中间指定大小的区域
- (UIImage *)croppingCenterSquareToSize:(CGSize)size {
    // not equivalent to image.size (which depends on the imageOrientation)!
    CGFloat refWidth = CGImageGetWidth(self.CGImage);
    CGFloat refHeight = CGImageGetHeight(self.CGImage);

    CGFloat x = (CGFloat) ((refWidth - size.width) / 2.0);
    CGFloat y = (CGFloat) ((refHeight - size.height) / 2.0);

    CGRect cropRect = CGRectMake(x, y, size.width, size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);

    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:0.0 orientation:self.imageOrientation];
    CGImageRelease(imageRef);

    return cropped;
}

@end


@implementation UIImage (Bordered)

- (UIImage *)imageBorderedWithColor:(UIColor *)color borderWidth:(CGFloat)width {
    UIImage *image = self;

    UIGraphicsBeginImageContextWithOptions(self.size, YES, self.scale);
    [self drawAtPoint:CGPointZero];
    [color setStroke];
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:width * 2];
    [path addClip];
    [image drawInRect:rect];
    path.lineWidth = width;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

- (UIImage *)imageWithBorderWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGRect rect = CGRectZero;
    rect.size = self.size;
    CGRect pathRect = CGRectInset(rect, lineWidth / 2.0, lineWidth / 2.0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:cornerRadius];

    CGContextBeginPath(context);
    CGContextAddPath(context, path.CGPath);
    CGContextClosePath(context);
    CGContextClip(context);

    [self drawAtPoint:CGPointZero];

    CGContextRestoreGState(context);

    [[UIColor whiteColor] setStroke];
    path.lineWidth = lineWidth;
    [path stroke];

    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return finalImage;
}

@end


@implementation UIImage (AverageColor)

//获得图片的平均色值
- (UIColor *)averageColor {

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);

    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

@end

@implementation UIImage(Alpha)

//修改图片透明度
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);

    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);

    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

    CGContextSetAlpha(ctx, alpha);

    CGContextDrawImage(ctx, area, self.CGImage);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

@end


@implementation UIImage(Blur)

//模糊化
-(UIImage *)blurImageWithRadius:(CGFloat)radius{
    return [self blurWithRect:CGRectMake(0, 0, self.size.width, self.size.height) radius:radius];
}

//将一张图片模糊化
- (UIImage *)blurWithRect:(CGRect)rect radius:(CGFloat)radius{
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];

    // Apply Affine-Clamp filter to stretch the image so that it does not
    // look shrunken when gaussian blur is applied
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:inputImage forKey:@"inputImage"];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];

    // Apply gaussian blur filter with radius of 30
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:clampFilter.outputImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:@(radius) forKey:@"inputRadius"];

    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:gaussianBlurFilter.outputImage fromRect:[inputImage extent]];

    // Set up output context.
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();

    // Invert image coordinates
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -rect.size.height);

    // Draw base image.
    CGContextDrawImage(outputContext, rect, cgImage);

    // Apply white tint
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithWhite:1 alpha:0.2].CGColor);
    CGContextFillRect(outputContext, rect);
    CGContextRestoreGState(outputContext);

    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return outputImage;
}

@end


@implementation UIImage(ScaleSize)

//image的Size的分辨率倍数
-(CGSize)scaleSize{
    CGFloat scale = [UIScreen mainScreen].scale;
    return CGSizeMake(self.size.width * scale, self.size.height * scale);
}

-(CGSize)scaleSize:(CGFloat)scale{
    CGFloat scal = [UIScreen mainScreen].scale;
    return CGSizeMake(self.size.width * scal * scale, self.size.height * scal * scale);
}

//压缩图片到小于指定大小，以Byte为单元
- (NSData *)compressWithInMaxFileSize:(int)maxFileSize {
    CGFloat compression = 0.8f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0);
    while ([imageData length] > maxFileSize && compression > maxCompression){
        imageData = UIImageJPEGRepresentation(self, compression);
        compression *= 0.8;
    }
    return imageData;
}

//压缩图片到小于指定大小，以Byte为单元
-(UIImage *)compressLessThan:(int)fileSize{
    NSData *imageData = [self compressWithInMaxFileSize:fileSize];
    UIImage *image=[UIImage imageWithData:imageData];
    return image;
}

//包含bitmap 和 UIImage instance container 的大小
- (size_t) memorySize{
    CGImageRef image = self.CGImage;
    size_t instanceSize = class_getInstanceSize(self.class);
    size_t pixmapSize = CGImageGetHeight(image) * CGImageGetBytesPerRow(image);
    size_t totalSize = instanceSize + pixmapSize;
    return totalSize;
}

//实际的bitmap大小，不包含UIImage instance container
- (size_t) calculatedSize {
    return CGImageGetHeight(self.CGImage) * CGImageGetBytesPerRow(self.CGImage);
}

@end


@implementation UIImage (Animation)

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];

    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {

        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }

    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.

    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }

    CFRelease(cfFrameProperties);
    return frameDuration;
}


- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }

    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;

    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;

    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (CGFloat) ((size.height - scaledSize.height) * 0.5);
    }
    else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (CGFloat) ((size.width - scaledSize.width) * 0.5);
    }

    NSMutableArray *scaledImages = [NSMutableArray array];

    for (UIImage *image in self.images) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);

        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

        [scaledImages addObject:newImage];

        UIGraphicsEndImageContext();
    }

    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}

//压缩图片到小于指定大小,(尺寸变化)，以Byte为单元
- (UIImage *)scaleImageDataInMaxFileSize:(int)maxFileSize {
    CGFloat compression = 0.9f;
    UIImage *image = nil;
    while ([self calculatedSize] > maxFileSize ){
        image = [self sd_animatedImageByScalingAndCroppingToSize:CGSizeMake((CGFloat) (self.size.width * compression), (CGFloat) (self.size.height * compression))];
    }
    return image;
}

//压缩图片到小于指定大小,(尺寸不变)，以Byte为单元
- (UIImage *)compressImageDataInMaxFileSize:(int)maxFileSize {

//    NSData *data = [self sd_imageDataAsFormat:SDImageFormatGIF];
//    imageData = UIImageJPEGRepresentation(image, compression);

    return nil;
}


@end


@implementation UIImage (Bundle)

+(UIImage*)imageNamed:(NSString*)name ofBundle:(NSString*)bundleName{
    UIImage *image = nil;
    NSString *image_name = [NSString stringWithFormat:@"%@.png",name];
    NSString *resourcePath = [[NSBundle mainBundle]resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    NSString *image_path = [bundlePath stringByAppendingPathComponent:image_name];
    
    //NSString* path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]];
    
    //image = [UIImage imageWithContentsOfFile:image_path];
    image = [[UIImage alloc]initWithContentsOfFile:image_path];
    
    return image;
}

+(NSString*)imageInbundlePath:(NSString*)name ofBundle:(NSString*)bundleName{
    NSString *image_name = [NSString stringWithFormat:@"%@.png",name];
    NSString *resourcePath = [[NSBundle mainBundle]resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    NSString *image_path = [bundlePath stringByAppendingPathComponent:image_name];
    
    return image_path;
}


@end


