//
//  TCDContact.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 09.10.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDContact.h"

@implementation TCDContact

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName actionHandler:(void (^)())handler
{
    if (self = [super init]) {
        self.title = title;
        self.imageName = imageName;
        self.actionHandler = handler;
    }
    return self;
}

@end
