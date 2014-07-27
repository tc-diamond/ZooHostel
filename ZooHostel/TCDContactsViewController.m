//
//  TCDContactsViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 13.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDContactsViewController.h"
#import <RESideMenu/RESideMenu.h>

NSString * const kContactsSegueIdentifier = @"ContactsSegueIdentifier";

@interface TCDContactsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBarButton;

@end

@implementation TCDContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}


#pragma mark - Navigation

- (IBAction)menuBarButtonTapped:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
