//
//  TCDMainViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 14.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDMainViewController.h"
#import <RESideMenu/RESideMenu.h>

NSString * const kMainSegueIdentifier = @"MainSegueIdentifier";

@interface TCDMainViewController ()

@end

@implementation TCDMainViewController

#pragma mark - Navigation

- (IBAction)menuBarButtonTapped:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
    [super scrollViewDidScroll:scrollView];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
