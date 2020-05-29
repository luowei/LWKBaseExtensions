//
// Created by Luo Wei on 2020/5/30.
//

#import "UIDevice+Addtions.h"


@implementation UIDevice (Addtions)

- (BOOL)isSimulator {
    if([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){9, 0, 0}]) {
        return [NSProcessInfo processInfo].environment[@"SIMULATOR_DEVICE_NAME"] != nil;
    } else {
        return [[self model].lowercaseString containsString:@"simulator"];
    }
}

@end