//
// Created by Luo Wei on 2020/5/30.
//

#import "UIPasteboard+Addtions.h"
#import "UIDevice+Addtions.h"


@implementation UIPasteboard (Addtions)

+(instancetype)myPasteboard {
    if([UIDevice.currentDevice isSimulator]){
        return nil;
    }
    return [UIPasteboard generalPasteboard];
}

@end