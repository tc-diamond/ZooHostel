//
//  TCDMainViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 14.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDMainViewController.h"
#import "UIViewController+SlidingSetup.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

@interface TCDMainViewController ()

@end

@implementation TCDMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self slidingViewControllerSetup];
}

#pragma mark - Navigation

- (IBAction)menuBarButtonTapped:(id)sender
{
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredLeft)
    {
        [self.slidingViewController resetTopViewAnimated:YES];
    }
    else
    {
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
