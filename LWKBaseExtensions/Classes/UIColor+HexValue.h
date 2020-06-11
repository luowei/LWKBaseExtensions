//
//  UIColor+HexValue.h
//  MyInputMethod
//
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexValue)

+ (UIColor *)colorWithRGBAString:(NSString *)RGBAString;

+ (UIColor *)colorWithHexString:(NSString *)hex;

- (NSString *)rgbHexString;

//从UIColor得到RGBA字符串
+(NSString *)rgbaStringFromUIColor:(UIColor *)color;

+(NSString *)hexValuesFromUIColor:(UIColor *)color;

+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha;

@end


@interface UIColor (Ext)

//颜色反转
- (UIColor *)reverseColor;

//是否是亮色
- (BOOL)isLight;

//亮度增加 百分之percentage
-(UIColor *)lighterByPercentage:(CGFloat)percentage;

//亮度减小 百分之percentage
-(UIColor *)darkerByPercentage:(CGFloat)percentage;

//键盘小文字颜色，根据大文字颜色自动调整
-(UIColor *)topTipColor;

//弹窗背景色
-(UIColor *)adjustColorWithPercentage:(CGFloat)percentage;

@end