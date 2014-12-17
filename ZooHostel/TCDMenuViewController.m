//
//  TCDMenuViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 13.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDAboutUsViewController.h"
#import "TCDCharityViewController.h"
#import "TCDContactsViewController.h"
#import "TCDCrewViewController.h"
#import "TCDMenuViewController.h"
#import "TCDProgramTypesViewController.h"
#import "TCDMainViewController.h"
#import "TCDPrincipesViewController.h"
#import "TCDPhotoViewController.h"
#import "TCDTermsViewController.h"
#import "UIViewController+ReSideMenu.h"
#import <RESideMenu/RESideMenu.h>

@interface TCDMenuViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) CGFloat headerImageYOffset;
@property (copy, nonatomic) NSArray *dataSource;
@property (copy, nonatomic) NSArray *seguesSource;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation TCDMenuViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = @[@"Главная", @"О нас", @"Виды путевок", @"Наша команда", @"Наши принципы", @"Условия приема", @"Социальная программа", @"Контакты", @"Фотографии"];
    self.seguesSource = @[kMainSegueIdentifier, TCDAboutUsViewControllerIdentifier, TCDProgramTypesViewControllerIdentifier, TCDCrewViewControllerIdentifier, TCDPrincipesViewControllerSegueIdentifier, TCDTermsViewControllerIdentifier, TCDCharitySegueIdentifier, kContactsSegueIdentifier, kPhotoSegueIdentifier];
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadData];
    CGFloat topInset = (self.view.bounds.size.height - self.tableView.contentSize.height) / 2;
    self.tableView.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
}

#pragma mark - Actions

- (void)selectNext
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - UITableView
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    if ([indexPath isEqual:self.selectedIndexPath]) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.1f]]; // set color here
    [cell setSelectedBackgroundView:selectedBackgroundView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.seguesSource[indexPath.row]];
    [self.sideMenuViewController hideMenuViewController];
}

@end
