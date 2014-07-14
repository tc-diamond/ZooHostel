//
//  UIViewController+SlidingSetup.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 13.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "UIViewController+SlidingSetup.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

@implementation UIViewController (SlidingSetup)

- (void)slidingViewControllerSetup
{
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGesturePanning | ECSlidingViewControllerAnchoredGestureTapping;
    self.slidingViewController.panGesture.delegate = (id)self;
    self.slidingViewController.panGesture.cancelsTouchesInView = YES;
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    if (self.navigationController) {
//        self.navigationController.view.clipsToBounds = NO;
        self.navigationController.view.layer.shadowOpacity = 1.f;
        self.navigationController.view.layer.shadowRadius  = 10.0f;
        self.navigationController.view.layer.shadowOffset = CGSizeMake(0., 10.);
        self.navigationController.view.layer.shadowColor   = [UIColor blackColor].CGColor;
        self.navigationController.view.layer.shadowPath    = [UIBezierPath bezierPathWithRect:self.navigationController.view.bounds].CGPath;
    }else {
        self.view.layer.shadowOpacity = 1.f;
        self.view.layer.shadowRadius  = 10.0f;
        self.view.layer.shadowOffset = CGSizeMake(0., 10.);
        self.view.layer.shadowColor   = [UIColor blackColor].CGColor;
        self.view.layer.shadowPath    = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    }
    
}

@end
