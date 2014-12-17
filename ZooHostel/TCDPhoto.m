//
//  TCDPhoto.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 26.08.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDPhoto.h"

@implementation TCDPhoto

- (instancetype)initWithURL:(NSURL *)url presentationURL:(NSURL *)presentationUrl
{
    if (self = [super init]) {
        self.url = url;
        self.presentationUrl = presentationUrl;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, url:%@, presentationURL:%@, size: %fx%f", [super description], self.url.absoluteString, self.presentationUrl.absoluteString, self.size.width, self.size.height];
}

- (NSURL *)url
{
    NSString *stringUrl = [_url absoluteString];
    NSRange equalRange = [stringUrl rangeOfString:@"="];
    NSRange dotRangeLast = [stringUrl rangeOfString:@"." options:NSBackwardsSearch];
    if (equalRange.location != NSNotFound) {
        stringUrl = [stringUrl stringByReplacingCharactersInRange:NSMakeRange(equalRange.location, dotRangeLast.location - equalRange.location) withString:@""];
    }
    
    return [NSURL URLWithString:stringUrl];
}

- (BOOL)isEqual:(TCDPhoto *)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    if ([[self.url absoluteString] isEqualToString:[object.url absoluteString]]) {
        return YES;
    }
    return NO;
}

@end
