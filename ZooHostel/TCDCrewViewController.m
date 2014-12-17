//
//  TCDCrewViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 19.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDCrewViewController.h"
#import "TCDPrincipesViewController.h"
#import <RESideMenu/RESideMenu.h>

NSString * const TCDCrewViewControllerIdentifier = @"CrewSegueIdentifier";

@implementation TCDCrewViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView scrolledToBottom])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Принципы" style:UIBarButtonItemStylePlain target:self action:@selector(principes)];
    }
}

- (void)principes
{
    [((TCDSideMenu *)self.sideMenuViewController) nextTableSelection];
    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:TCDPrincipesViewControllerSegueIdentifier];
}


@end
