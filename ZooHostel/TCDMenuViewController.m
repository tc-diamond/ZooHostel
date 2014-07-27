//
//  TCDMenuViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 13.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDMenuViewController.h"
#import "TCDProgramTypesViewController.h"
#import "TCDCrewViewController.h"
#import "TCDMainViewController.h"
#import "TCDAboutUsViewController.h"
#import "TCDContactsViewController.h"
#import "TCDPhotoViewController.h"
#import "UIViewController+ReSideMenu.h"
#import <RESideMenu/RESideMenu.h>

static NSString * const kPrincipesSegueIdentifier = @"PrincipesSegueIdentifier";
static NSString * const kTermsSegueIdentifier = @"TermsSegueIdentifier";

@interface TCDMenuViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) UIImageView *headerImageView;
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
    
    self.dataSource = @[@"Главная", @"О нас", @"Виды путевок", @"Наша команда", @"Наши принципы", @"Условия приема", @"Контакты", @"Фотографии"];
    self.seguesSource = @[kMainSegueIdentifier, kAboutUsSegueIdentifier, kProgramTypesSegueIdentifier, kCrewSegueIdentifier, kPrincipesSegueIdentifier, kTermsSegueIdentifier, kContactsSegueIdentifier, kPhotoSegueIdentifier];
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
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

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat scrollOffset = scrollView.contentOffset.y;
//    CGRect headerImageFrame = self.headerImageView.frame;
//    
//    if (scrollOffset <= -70) {
//        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -70);
//        return;
//    }
//    
//    // Adjust image proportionally
//    headerImageFrame.origin.y = self.headerImageYOffset - scrollOffset / 3;
//    
//    self.headerImageView.frame = headerImageFrame;
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end
