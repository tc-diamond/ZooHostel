//
//  TCDCrewViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 19.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDCrewViewController.h"
#import "UIViewController+SlidingSetup.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

NSString * const kCrewSegueIdentifier = @"CrewSegueIdentifier";

@interface TCDCrewViewController ()

@end

@implementation TCDCrewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self slidingViewControllerSetup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
