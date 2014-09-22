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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"Background"];
//        CGFloat heightByWidth = self.scrollView.contentSize.height / self.scrollView.contentSize.width;
    
    //    CGSize *backgroundSize = CGSizeMake(self.scrollView.contentSize.width, <#CGFloat height#>)
    
    CGFloat scrollHeight = self.scrollView.bounds.size.height;
    self.backgroundImageView = [[UIImageView alloc]
                           initWithFrame:CGRectMake(0,
                                                    0,
                                                    self.scrollView.bounds.size.width,
                                                    scrollHeight + (self.scrollView.bounds.size.height - scrollHeight) / 2)];
    self.backgroundImageView.image = image;
//    self.backgroundView.blurRadius = 35;
//    [self.view insertSubview:self.backgroundImageView atIndex:0];
}

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
