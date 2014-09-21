//
//  TCDPhotoAlbum.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 26.08.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDPhotoAlbum.h"

@implementation TCDPhotoAlbum

- (instancetype)init
{
    if (self = [super init]) {
        self.photos = [NSMutableArray array];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title photos:(NSArray *)photos
{
    if (self = [self init]) {
        self.title = title;
        self.photos = [photos mutableCopy];
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, title:%@, photos:%@", [super description], self.title, self.photos];
}

@end
