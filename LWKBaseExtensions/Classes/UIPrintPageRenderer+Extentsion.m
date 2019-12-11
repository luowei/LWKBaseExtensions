//
// Created by Luo Wei on 2017/7/15.
// Copyright (c) 2017 wodedata. All rights reserved.
//

#import "UIPrintPageRenderer+Extentsion.h"


@implementation UIPrintPageRenderer (Extentsion)

@end


@implementation UIPrintPageRenderer (PDF)

- (NSData *)printToPDF {
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil);
    [self prepareForDrawingPages:NSMakeRange(0, (NSUInteger) self.numberOfPages)];

    CGRect bounds = UIGraphicsGetPDFContextBounds();
    for (int i = 0; i < self.numberOfPages; i++) {
        UIGraphicsBeginPDFPage();
        [self drawPageAtIndex:i inRect:bounds];
    }

    UIGraphicsEndPDFContext();
    return pdfData;
}

@end
