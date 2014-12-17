//
//  TCDScrollableViewController.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 21.09.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDScrollableViewController.h"

@interface TCDScrollableViewController ()

@property (strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation TCDScrollableViewController

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect backgroundRect = self.backgroundImageView.frame;
    CGFloat newY = -scrollView.contentOffset.y / 2;
    if (newY <= 0 && scrollView.bounds.size.height - newY <= self.backgroundImageView.bounds.size.height) {
        backgroundRect.origin.y = newY;
    }
    self.backgroundImageView.frame = backgroundRect;
}

@end
