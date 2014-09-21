//
//  TCDPhoto.h
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 26.08.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCDPhoto : NSObject

@property (nonatomic, assign) CGSize size;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSURL *presentationUrl;

- (instancetype)initWithURL:(NSURL *)url presentationURL:(NSURL *)presentationUrl;

@end
