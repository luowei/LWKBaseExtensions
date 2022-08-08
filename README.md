# LWKBaseExtensions

[![CI Status](https://img.shields.io/travis/luowei/LWKBaseExtensions.svg?style=flat)](https://travis-ci.org/luowei/LWKBaseExtensions)
[![Version](https://img.shields.io/cocoapods/v/LWKBaseExtensions.svg?style=flat)](https://cocoapods.org/pods/LWKBaseExtensions)
[![License](https://img.shields.io/cocoapods/l/LWKBaseExtensions.svg?style=flat)](https://cocoapods.org/pods/LWKBaseExtensions)
[![Platform](https://img.shields.io/cocoapods/p/LWKBaseExtensions.svg?style=flat)](https://cocoapods.org/pods/LWKBaseExtensions)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


### ALAsset  

```Objective-C
@interface ALAsset (Extension)
//从asset获得一张指定大小的缩略图
- (UIImage *)thumbnailWithMaxPixelSize:(NSUInteger)size;
@end
```

### CALayer  

```Objective-C
@interface CALayer (Ext)
//layer边框颜色
@property(nonatomic, assign) UIColor *borderUIColor;
@end
```

### NSArray  

```Objective-C
@interface NSArray (Extension)
- (BOOL)containsString:(NSString *)string;
-(BOOL)containsStringItem:(NSString*)string;

-(NSUInteger)indexOfStringObject:(NSString *)string;
@end
```

### NSData  

```Objective-C
@interface NSData (Md5)
-(NSString *)base64Encode;

- (NSString *)md5;

//返回16字节的摘要
- (NSData *)md5Data;
@end
```

### NSDictionary

```Objective-C
@interface NSObject (KeyPath)
this method ensures app does not crash if sent to  unrecognized selector
-(id) objectForKeyPath:(NSString *)keyPath;
@end

@interface NSDictionary (KeyPath)
keyPath is expected to be separated with dot notation
-(id) objectForKeyPath:(NSString *)keyPath;
@end

@interface NSMutableDictionary (KeyPath)
keyPath is expected to be separated with dot notation
-(void) setObject:(id)object forKeyPath:(NSString *)keyPath;
@end
```

### NSObject  

```Objective-C
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
```

### NSString   

```Objective-C
@interface NSString (Addtion)

-(BOOL)isBlank;
-(BOOL)isNotBlank;
-(BOOL)containsChineseCharacters;

- (NSString *)subStringWithRegex:(NSString *)regexText matchIndex:(NSUInteger)index;
- (NSArray<NSString *> *)matchStringWithRegex:(NSString *)regexText;

@end


@interface NSString(Match)

- (BOOL)isMatchString:(NSString *)pattern;
- (BOOL)isiTunesURL;
- (BOOL)isDomain;
- (BOOL)isHttpURL;

@end
```

### NSURL   

```Objective-C
@interface NSURL (Extension)

- (NSDictionary *)queryDictionary;
-(BOOL)urlIsImage;

@end
```

### UIButton   

```Objective-C
@interface UIButton (Extension)
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;
@end
```

### UIColor

```Objective-C
@interface UIColor (CrossFade)
+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor
                               secondColor:(UIColor *)secondColor
                                   atRatio:(CGFloat)ratio;
+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor atRatio:(CGFloat)ratio compareColorSpaces:(BOOL)compare;

//根据比例与alpha值得到一个过渡色
+ (UIColor *)colorBetweenFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor atRatio:(CGFloat)ratio withAlpha:(CGFloat)alpha;
+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor
                                  lastColor:(UIColor *)lastColor
                                    inSteps:(NSUInteger)steps;
+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor
                                  lastColor:(UIColor *)lastColor
                          withRatioEquation:(float (^)(float input))equation
                                    inSteps:(NSUInteger)steps;
+ (UIColor *)colorConvertedToRGBA:(UIColor *)colorToConvert;
+ (CAKeyframeAnimation *)keyframeAnimationForKeyPath:(NSString *)keyPath
                                            duration:(NSTimeInterval)duration
                                   betweenFirstColor:(UIColor *)firstColor
                                           lastColor:(UIColor *)lastColor;
+ (CAKeyframeAnimation *)keyframeAnimationForKeyPath:(NSString *)keyPath
                                            duration:(NSTimeInterval)duration
                                   betweenFirstColor:(UIColor *)firstColor
                                           lastColor:(UIColor *)lastColor
                                   withRatioEquation:(float (^)(float))equation
                                             inSteps:(NSUInteger)steps;

@end
```

```Objective-C
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
```

```Objective-C
@interface UIDevice (Addtions)
- (BOOL)isSimulator;
@end
```

### UIImage   

```Objective-C
@interface UIImage (Extension)

+(UIImage *)imageNamed:(NSString *)imageName inBundleNamed:(NSString *)bundleName;

@end

@interface UIImage (Color)

/**
* 给指定的图片染色
*/
- (UIImage *)imageWithOverlayColor:(UIColor *)color;

- (UIImage *)imageWith_TintColor:(UIColor *)tintColor;

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *)imageWith_TintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

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

//裁切圆角
-(UIImage *)withRoundedCorners:(CGFloat)radius;

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
```

### UIPasteboard  

```Objective-C
@interface UIPasteboard (Addtions)
+(instancetype)myPasteboard;
@end
```

### UIPrintPageRenderer  

```Objective-C
@interface UIPrintPageRenderer (PDF)
- (NSData*) printToPDF;
@end
```

### UIResponder  

```Objective-C
@interface UIResponder (Extension)
//打开指定url
- (void)openURLWithUrl:(NSURL *)url;
//打开指定urlString
- (void)openURLWithString:(NSString *)urlString;

//检查是否能打开指定urlString
- (BOOL)canOpenURLWithString:(NSString *)urlString;
@end
```

### UIView   

```Objective-C
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

//判断是否是深色模式
-(BOOL)isDarkStyle;
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
```


## Requirements

## Installation

LWKBaseExtensions is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LWKBaseExtensions'
```

**Carthage**
```ruby
github "luowei/LWKBaseExtensions"
```

## Author

luowei, luowei@wodedata.com

## License

LWKBaseExtensions is available under the MIT license. See the LICENSE file for more info.
