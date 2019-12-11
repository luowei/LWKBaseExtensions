//
// Created by Luo Wei on 2017/5/11.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

@interface ALAsset (Extension)

//从asset获得一张指定大小的缩略图
- (UIImage *)thumbnailWithMaxPixelSize:(NSUInteger)size;

@end
