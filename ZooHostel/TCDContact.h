//
//  TCDContact.h
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 09.10.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCDContact : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) void (^actionHandler)();

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName actionHandler:(void (^)())handler;

@end
