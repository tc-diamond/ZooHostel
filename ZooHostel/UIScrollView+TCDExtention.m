//
//  UIScrollView+TCDExtention.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 23.09.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "UIScrollView+TCDExtention.h"

@implementation UIScrollView (TCDExtention)

- (BOOL)scrolledToBottom
{
    CGFloat height = self.frame.size.height;
    
    CGFloat contentYoffset = self.contentOffset.y;
    
    CGFloat distanceFromBottom = self.contentSize.height - contentYoffset;
    
    return (distanceFromBottom <= height);
}

@end
