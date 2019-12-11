//
// Created by Luo Wei on 2017/5/14.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+(UIImage *)imageNamed:(NSString *)imageName inBundleNamed:(NSString *)bundleName;

@end

@interface UIImage (Color)

/**
* 给指定的图片染色
*/
- (UIImage *)imageWithOverlayColor:(UIColor *)color;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

//根据颜色与矩形区生成一张图片
+ (UIImage *)imageFromColor:(UIColor *)color withRect:(CGRect)rect;

//根据颜色与Size生成一张图片
+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size;

//根据View获得一张图片
+ (UIImage *)imageWithView:(UIView *)view;

//把字符串依据指定的字体属性及大小转换成图片
+ (UIImage *)imageFromString:(NSString *)string attributes:(NSDictionary *)attributes size:(CGSize)size;

@end


@interface UIImage (Cut)

//根据指定矩形区,剪裁图片
- (UIImage *)cutImageWithRect:(CGRect)cutRect;

//在指定大小的绘图区域内,将img2合成到img1上
+ (UIImage *)combineBGImage:(UIImage *)bgImg withImage:(UIImage *)img
                    andSize:(CGSize)imgSize inSize:(CGSize)size;

//在指定大小的绘图区域内,将img2合成到img1上
+ (UIImage *)addImageToImage:(UIImage *)img withImage2:(UIImage *)img2
                     andRect:(CGRect)cropRect withImageSize:(CGSize)size;

//把一张图片缩放到指定大小
- (UIImage *)imageToscaledSize:(CGSize)newSize;

//把一张图片按比例缩放到指定大小
- (UIImage *)scaleToSizeKeepAspect:(CGSize)size;

//把一张图片缩放到微信可接收的200x200的缩略图
-(UIImage *)scaleToWXThumbnailSizeKeepAspect:(CGSize)size;

//把图片按指定比例缩放
- (UIImage *)imageToScale:(CGFloat)scale;

//截取中间指定大小的区域
- (UIImage *)croppingCenterSquareToSize:(CGSize)size;

@end


@interface UIImage (Bordered)

-(UIImage *)imageBorderedWithColor:(UIColor *)color borderWidth:(CGFloat)width;

- (UIImage *)imageWithBorderWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius;

@end


@interface UIImage (AverageColor)

//获得图片的平均色值
- (UIColor *)averageColor;

@end

@interface UIImage (Alpha)

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

@end

@interface UIImage (Blur)

//模糊化
-(UIImage *)blurImageWithRadius:(CGFloat)radius;

//将一张图片模糊化
- (UIImage *)blurWithRect:(CGRect)rect radius:(CGFloat)radius;

@end

@interface UIImage (ScaleSize)

//image的Size的分辨率倍数
-(CGSize)scaleSize;

-(CGSize)scaleSize:(CGFloat)scale;

//压缩图片到小于指定大小，以Byte为单元
- (NSData *)compressWithInMaxFileSize:(int)maxFileSize;

//压缩图片到小于指定大小，以Byte为单元
-(UIImage *)compressLessThan:(int)fileSize;

//包含bitmap 和 UIImage instance container 的大小
- (size_t) memorySize;

//实际的bitmap大小，不包含UIImage instance container
- (size_t) calculatedSize;

@end


@interface UIImage (Animation)

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

//压缩图片到小于指定大小,(尺寸变化)，以Byte为单元
- (UIImage *)scaleImageDataInMaxFileSize:(int)maxFileSize;

@end


@interface UIImage (Bundle)

+(UIImage*)imageNamed:(NSString*)name ofBundle:(NSString*)bundleName;
+(NSString*)imageInbundlePath:(NSString*)name ofBundle:(NSString*)bundleName;

@end



