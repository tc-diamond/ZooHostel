//
//  TCDScrollableViewController.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 21.09.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDScrollableViewController.h"
#import <GRKBlurView/GRKBlurView.h>

@interface TCDScrollableViewController ()

@property (strong, nonatomic) GRKBlurView *backgroundView;
@property (assign, nonatomic) BOOL isFirstLayout;

@end

@implementation TCDScrollableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFirstLayout = YES;
    
    
    UIImage *image = [UIImage imageNamed:@"Background"];
//        CGFloat heightByWidth = self.scrollView.contentSize.height / self.scrollView.contentSize.width;
    
    //    CGSize *backgroundSize = CGSizeMake(self.scrollView.contentSize.width, <#CGFloat height#>)
    
    CGFloat scrollHeight = self.scrollView.bounds.size.height;
    self.backgroundView = [[GRKBlurView alloc]
                           initWithFrame:CGRectMake(0,
                                                    0,
                                                    self.scrollView.bounds.size.width,
                                                    scrollHeight + (self.scrollView.bounds.size.height - scrollHeight) / 2)];
    self.backgroundView.targetImage = image;
    self.backgroundView.blurRadius = 35;
    [self.view insertSubview:self.backgroundView atIndex:0];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect backgroundRect = self.backgroundView.frame;
    CGFloat newY = -scrollView.contentOffset.y / 2;
    if (newY <= 0 && scrollView.bounds.size.height - newY <= self.backgroundView.bounds.size.height) {
        backgroundRect.origin.y = newY;
    }
    self.backgroundView.frame = backgroundRect;
}

@end
