//
// Created by Luo Wei on 2017/5/11.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "ALAsset+Extension.h"

#pragma mark - ALAsset Category

// Helper methods for thumbnailForAsset:maxPixelSize:
static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count) {
    ALAssetRepresentation *rep = (__bridge id) info;

    NSError *error = nil;
    size_t countRead = [rep getBytes:(uint8_t *) buffer fromOffset:position length:count error:&error];

    if (countRead == 0 && error) {
        // We have no way of passing this info back to the caller, so we log it, at least.
        NSLog(@"thumbnailForAsset:maxPixelSize: got an error reading an asset: %@", error);
    }

    return countRead;
}

static void releaseAssetCallback(void *info) {
    // The info here is an ALAssetRepresentation which we CFRetain in thumbnailForAsset:maxPixelSize:.
    // This release balances that retain.
    CFRelease(info);
}

@implementation ALAsset (Extension)

//从asset获得一张指定大小的缩略图
- (UIImage *)thumbnailWithMaxPixelSize:(NSUInteger)size {
    NSParameterAssert(size > 0);

    ALAssetRepresentation *rep = [self defaultRepresentation];

    CGDataProviderDirectCallbacks callbacks = {
            .version = 0,
            .getBytePointer = NULL,
            .releaseBytePointer = NULL,
            .getBytesAtPosition = getAssetBytesCallback,
            .releaseInfo = releaseAssetCallback,
    };

    CGDataProviderRef provider = CGDataProviderCreateDirect((void *) CFBridgingRetain(rep), [rep size], &callbacks);
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);

    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{
            (NSString *) kCGImageSourceCreateThumbnailFromImageAlways: @YES,
            (NSString *) kCGImageSourceThumbnailMaxPixelSize: @(size),
            (NSString *) kCGImageSourceCreateThumbnailWithTransform: @YES,
    });
    CFRelease(source);
    CFRelease(provider);

    if (!imageRef) {
        return nil;
    }

    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];

    CFRelease(imageRef);

    return toReturn;
}

@end


