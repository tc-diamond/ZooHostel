//
//  TCDPhotoAlbum.h
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 26.08.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCDPhotoAlbum : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray *photos;

- (instancetype)initWithTitle:(NSString *)title photos:(NSArray *)photos;

@end
