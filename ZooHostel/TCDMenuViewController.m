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
static NSString * const kContactsSegueIdentifier = @"ContactsSegueIdentifier";
static NSString * const kPhotoSegueIdentifier = @"PhotoSegueIdentifier";

@interface TCDMenuViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *dataSource;
@property (copy, nonatomic) NSArray *seguesSource;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation TCDMenuViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = @[@"Главная", @"Контакты", @"Фотографии"];
    self.seguesSource = @[kMainSegueIdentifier, kContactsSegueIdentifier, kPhotoSegueIdentifier];
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // Do any additional setup after loading the view.
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end
