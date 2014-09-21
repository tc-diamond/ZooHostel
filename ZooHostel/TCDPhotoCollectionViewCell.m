//
//  TCDPhotoCollectionViewCell.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 13.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDPhotoCollectionViewCell.h"
#import "EXPhotoViewer.h"

@implementation TCDPhotoCollectionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}

- (void)tapped:(UITapGestureRecognizer*)gesture
{
    [EXPhotoViewer showImageFrom:self.imageView];
}

@end
