//
// Created by Luo Wei on 2017/5/8.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "CALayer+Extension.h"


@implementation CALayer (BorderColor)

- (void)setBorderUIColor:(UIColor *)borderUIColor {
    self.borderColor = borderUIColor.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
