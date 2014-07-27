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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:gesture];
        self.layer.cornerRadius = 4;
    }
    return self;
}

- (void)tapped:(UITapGestureRecognizer*)gesture
{
    [EXPhotoViewer showImageFrom:self.imageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
