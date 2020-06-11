//
//  UIColor+HexValue.m
//  MyInputMethod
//
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//

#import "UIColor+HexValue.h"

@implementation UIColor (HexValue)

+ (UIColor *)colorWithRGBAString:(NSString *)RGBAString {
    UIColor *color = nil;

    NSArray *rgbaComponents = [RGBAString componentsSeparatedByString:@","];
    float RED = 0.0f;
    float GREEN = 0.0f;
    float BLUE = 0.0f;
    float ALPHA = 0.0f;

    //string like : 127,127,127
    if ([rgbaComponents count] == 3) {
        RED = [(NSString *) rgbaComponents[0] floatValue] / 255;
        GREEN = [(NSString *) rgbaComponents[1] floatValue] / 255;
        BLUE = [(NSString *) rgbaComponents[2] floatValue] / 255;

        color = [UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:1.0f];

        //string like : 127,127,127,255
    } else if ([rgbaComponents count] == 4) {
        RED = [(NSString *) rgbaComponents[0] floatValue] / 255;
        GREEN = [(NSString *) rgbaComponents[1] floatValue] / 255;
        BLUE = [(NSString *) rgbaComponents[2] floatValue] / 255;
        ALPHA = [(NSString *) rgbaComponents[3] floatValue] / 255;

        color = [UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA];
    }

    return color;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:1];
            green = [self colorComponentFrom:colorString start:1 length:1];
            blue = [self colorComponentFrom:colorString start:2 length:1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom:colorString start:0 length:1];
            red = [self colorComponentFrom:colorString start:1 length:1];
            green = [self colorComponentFrom:colorString start:2 length:1];
            blue = [self colorComponentFrom:colorString start:3 length:1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:2];
            green = [self colorComponentFrom:colorString start:2 length:2];
            blue = [self colorComponentFrom:colorString start:4 length:2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom:colorString start:0 length:2];
            red = [self colorComponentFrom:colorString start:2 length:2];
            green = [self colorComponentFrom:colorString start:4 length:2];
            blue = [self colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            [NSException raise:@"Invalid color value" format:@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return (CGFloat) (hexComponent / 255.0);
}


+ (NSString *)hexValuesFromUIColor:(UIColor *)color {

    if (!color) {
        return nil;
    }

    if (color == [UIColor whiteColor]) {
        // Special case, as white doesn't fall into the RGB color space
        return @"ffffff";
    }

    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;

    [color getRed:&red green:&green blue:&blue alpha:&alpha];

    int redDec = (int) (red * 255);
    int greenDec = (int) (green * 255);
    int blueDec = (int) (blue * 255);

    NSString *returnString = [NSString stringWithFormat:@"%02x%02x%02x", (unsigned int) redDec, (unsigned int) greenDec, (unsigned int) blueDec];

    return returnString;

}

//从UIColor得到RGBA字符串
+ (NSString *)rgbaStringFromUIColor:(UIColor *)color {

    if (!color) {
        return nil;
    }

    if (color == [UIColor whiteColor]) {
        // Special case, as white doesn't fall into the RGB color space
        return @"255,255,255,255";
    }

    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;

    [color getRed:&red green:&green blue:&blue alpha:&alpha];

    int redDec = (int) (red * 255);
    int greenDec = (int) (green * 255);
    int blueDec = (int) (blue * 255);
    int alphaDec = (int) (alpha * 255);

    NSString *returnString = [NSString stringWithFormat:@"%d,%d,%d,%d", (unsigned int) redDec, (unsigned int) greenDec, (unsigned int) blueDec, (unsigned int) alphaDec];

    return returnString;

}

+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha {
    int red, green, blue;

    blue = hex & 0x0000FF;
    green = ((hex & 0x00FF00) >> 8);
    red = ((hex & 0xFF0000) >> 16);

    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

- (NSString *)rgbHexString{
    CGColorSpaceModel colorSpace = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    const CGFloat *components = CGColorGetComponents(self.CGColor);

    CGFloat r, g, b, a;

    if (colorSpace == kCGColorSpaceModelMonochrome) {
        r = components[0];
        g = components[0];
        b = components[0];
    }
    else if (colorSpace == kCGColorSpaceModelRGB) {
        r = components[0];
        g = components[1];
        b = components[2];
    }

    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
                                      lroundf(r * 255),
                                      lroundf(g * 255),
                                      lroundf(b * 255)];
}

- (NSString *)rgbaHexString{
    CGColorSpaceModel colorSpace = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    const CGFloat *components = CGColorGetComponents(self.CGColor);

    CGFloat r, g, b, a;

    if (colorSpace == kCGColorSpaceModelMonochrome) {
        r = components[0];
        g = components[0];
        b = components[0];
        a = components[1];
    }
    else if (colorSpace == kCGColorSpaceModelRGB) {
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }

    return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX",
                                      lroundf(r * 255),
                                      lroundf(g * 255),
                                      lroundf(b * 255),
                                      lroundf(a * 255)];
}


@end


@implementation UIColor (Ext)

//====== TO GET THE OPPOSIT COLORS =====
- (UIColor *)reverseColor {
    CGColorRef oldCGColor = self.CGColor;

    NSUInteger numberOfComponents = CGColorGetNumberOfComponents(oldCGColor);
    // can not invert - the only component is the alpha
    if (numberOfComponents == 1) {
        return [UIColor colorWithCGColor:oldCGColor];
    }

    const CGFloat *oldComponentColors = CGColorGetComponents(oldCGColor);
    CGFloat newComponentColors[numberOfComponents];

    int i = (int)numberOfComponents - 1;
    newComponentColors[i] = oldComponentColors[i]; // alpha
    while (--i >= 0) {
        newComponentColors[i] = 1 - oldComponentColors[i];
    }

    CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors);
    UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
    CGColorRelease(newCGColor);

    //=====For the GRAY colors 'Middle level colors'
    CGFloat white = 0;
    [self getWhite:&white alpha:nil];

    if (white > 0.3 && white < 0.67) {
        if (white >= 0.5)
            newColor = [UIColor darkGrayColor];
        else if (white < 0.5)
            newColor = [UIColor blackColor];

    }
    return newColor;
}

//是否是亮色
- (BOOL)isLight {
    CGFloat colorBrightness = 0;

    CGColorSpaceRef colorSpace = CGColorGetColorSpace(self.CGColor);
    CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(colorSpace);

    if(colorSpaceModel == kCGColorSpaceModelRGB){
        const CGFloat *componentColors = CGColorGetComponents(self.CGColor);

        colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    } else {
        [self getWhite:&colorBrightness alpha:0];
    }

    return (colorBrightness >= .5f);
}

//亮度增加 百分之percentage
-(UIColor *)lighterByPercentage:(CGFloat)percentage {
    return [self adjustByPercentage:fabs(percentage)];
}

//亮度减小 百分之percentage
-(UIColor *)darkerByPercentage:(CGFloat)percentage {
    return [self adjustByPercentage:-1 * fabs(percentage)];
}

-(UIColor *)adjustByPercentage:(CGFloat)percentage {
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    if([self getRed:&red green:&green blue:&blue alpha:&alpha]){
        return [UIColor colorWithRed:MIN(red+percentage/100,1.0) green:MIN(green+percentage/100,1.0) blue:MIN(blue+percentage/100,1.0) alpha:alpha];
    }else{
        return nil;
    }
}

//键盘小文字颜色，根据大文字颜色自动调整
-(UIColor *)topTipColor {
    if([self isLight]){
        return [self darkerByPercentage:20]; //变暗20%
    }else{
        return [self lighterByPercentage:20]; //增亮20%
    }
}

//弹窗背景色
-(UIColor *)adjustColorWithPercentage:(CGFloat)percentage {
    if([self isLight]){
        return [self darkerByPercentage:percentage]; //变暗
    }else{
        return [self lighterByPercentage:percentage]; //增亮
    }
}


@end
