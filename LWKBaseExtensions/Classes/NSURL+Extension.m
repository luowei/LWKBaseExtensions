//
// Created by Luo Wei on 2017/5/10.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "NSURL+Extension.h"


@implementation NSURL (Extension)

- (NSDictionary *)queryDictionary {
    NSMutableDictionary *queryStrings = @{}.mutableCopy;
    for (NSString *qs in [self.query componentsSeparatedByString:@"&"]) {
        // Get the parameter name
        NSString *key = [[qs componentsSeparatedByString:@"="] objectAtIndex:0];
        // Get the parameter value
        NSString *value = [[qs componentsSeparatedByString:@"="] objectAtIndex:1];
        //value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        queryStrings[key] = value;
    }
    return queryStrings;
}

-(BOOL)urlIsImage {
    NSMutableURLRequest *request = [[NSURLRequest requestWithURL:self] mutableCopy];
    NSURLResponse *response = nil;
    NSError *error = nil;
    [request setValue:@"HEAD" forKey:@"HTTPMethod"];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *mimeType = [response MIMEType];
    if(!mimeType){
        return false;
    }
    NSRange range = [mimeType rangeOfString:@"image"];
    return (range.location != NSNotFound);
}

@end

