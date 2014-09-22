//
//  TCDMainViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 14.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDMainViewController.h"
#import "TCDAboutUsViewController.h"
#import <RESideMenu/RESideMenu.h>

NSString * const kMainSegueIdentifier = @"MainSegueIdentifier";

@interface TCDMainViewController ()

@end

@implementation TCDMainViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
    
    if (self.navigationItem.rightBarButtonItem) {
        return;
    }
    
    if([scrollView scrolledToBottom])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"О Нас" style:UIBarButtonItemStylePlain target:self action:@selector(aboutUs)];
    }
}

- (void)aboutUs
{
    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:TCDAboutUsViewControllerIdentifier];
}

@end
