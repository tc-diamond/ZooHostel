//
//  TCDPrincipesViewController.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 23.09.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDPrincipesViewController.h"
#import "TCDTermsViewController.h"

NSString * const TCDPrincipesViewControllerSegueIdentifier = @"PrincipesSegueIdentifier";

@interface TCDPrincipesViewController ()

@end

@implementation TCDPrincipesViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView scrolledToBottom])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Условия" style:UIBarButtonItemStylePlain target:self action:@selector(terms)];
    }
}

- (void)terms
{
    [((TCDSideMenu *)self.sideMenuViewController) nextTableSelection];
    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:TCDTermsViewControllerIdentifier];
}

@end
