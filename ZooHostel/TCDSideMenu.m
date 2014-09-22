//
//  TCDSideMenu.m
//  ZooHostel
//
//  Created by Dmitriy Doroshchuk on 23.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDSideMenu.h"

static NSString * const leftMenuVCIdentifier = @"TCDMenuViewController";
static NSString * const contentMenuVCIdentifier = @"MainSegueIdentifier";

@interface TCDSideMenu ()

@end

@implementation TCDSideMenu

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:contentMenuVCIdentifier];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:leftMenuVCIdentifier];

    self.backgroundImage = [UIImage imageNamed:@"menuBackground"];

    self.panFromEdge = YES;
    self.panGestureEnabled = YES;
    self.parallaxEnabled = YES;
}

@end
