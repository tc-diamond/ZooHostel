//
//  TCDMenuViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 13.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDMenuViewController.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

static NSString * const kMainSegueIdentifier = @"MainSegueIdentifier";
static NSString * const kPhotoSegueIdentifier = @"SegueIdentifier";
static NSString * const kPhotoSegueIdentifier = @"PhotoSegueIdentifier";
static NSString * const kPhotoSegueIdentifier = @"PhotoSegueIdentifier";
static NSString * const kPhotoSegueIdentifier = @"PhotoSegueIdentifier";
static NSString * const kContactsSegueIdentifier = @"ContactsSegueIdentifier";
static NSString * const kPhotoSegueIdentifier = @"PhotoSegueIdentifier";

static CGFloat const kTableViewYOrigin = 100.f;
static CGFloat const kTopImageViewHeight = 139.f;

@interface TCDMenuViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *headerImageView;
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
    self.seguesSource = @[kMainSegueIdentifier, nil, nil, nil, nil, nil, kContactsSegueIdentifier, kPhotoSegueIdentifier];
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // Do any additional setup after loading the view.
    
    // Create an empty table header view with small bottom border view
    UIView *tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, self.view.frame.size.width, 120.0)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    UIView *blackBorderView = [[UIView alloc] initWithFrame: CGRectMake(0.0, 119.0, self.view.frame.size.width, 1.0)];
    blackBorderView.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.8];
    [tableHeaderView addSubview: blackBorderView];
    
    _tableView.tableHeaderView = tableHeaderView;
    
    // Create the underlying imageview and offset it
    self.headerImageYOffset = -30.0;
    self.headerImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"menu_top"]];
    CGRect headerImageFrame = self.headerImageView.frame;
    headerImageFrame.origin.x -= 30.f;
    headerImageFrame.origin.y = self.headerImageYOffset;
    self.headerImageView.frame = headerImageFrame;
    [self.view insertSubview: self.headerImageView belowSubview: self.tableView];
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
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    if ([indexPath isEqual:self.selectedIndexPath]) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.f]]; // set color here
    [cell setSelectedBackgroundView:selectedBackgroundView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.seguesSource[indexPath.row]];
    [self.slidingViewController resetTopViewAnimated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollOffset = scrollView.contentOffset.y;
    CGRect headerImageFrame = self.headerImageView.frame;
    
    if (scrollOffset <= -70) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -70);
        return;
    }
    
    if (scrollOffset < 0) {
        // Adjust image proportionally
        headerImageFrame.origin.y = self.headerImageYOffset - ((scrollOffset / 3));
    } else {
        // We're scrolling up, return to normal behavior
        headerImageFrame.origin.y = self.headerImageYOffset - scrollOffset / 3;
    }
    
    self.headerImageView.frame = headerImageFrame;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end
