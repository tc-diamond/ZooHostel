//
//  TCDTermsViewController.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 23.09.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDTermsViewController.h"
#import "TCDCharityViewController.h"

NSString * const TCDTermsViewControllerIdentifier = @"TermsSegueIdentifier";

@implementation TCDTermsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Соцпомощь" style:UIBarButtonItemStylePlain target:self action:@selector(charity)];
}

- (void)charity
{
    [((TCDSideMenu *)self.sideMenuViewController) nextTableSelection];
    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:TCDCharitySegueIdentifier];
}

@end
