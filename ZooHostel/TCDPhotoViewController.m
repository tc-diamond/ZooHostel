//
//  TCDPhotoViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 13.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "ArrayDataSource.h"
#import "ArrayDelegate.h"
#import "TCDPhotoCollectionViewCell.h"
#import "TCDPhotoViewController.h"
#import "UIPhotoGalleryView.h"
#import "UIPhotoGalleryViewController.h"
#import "UIViewController+SlidingSetup.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

static CGFloat const kDefaultCellHeight = 50;

@interface TCDPhotoViewController () <UIPhotoGalleryDataSource>

@property (strong, nonatomic) ArrayDataSource *arrayDataSource;
@property (strong, nonatomic) ArrayDelegate *arrayDelegate;
@property (strong, nonatomic) UIPhotoGalleryViewController *photoGalleryViewController;

@end

@implementation TCDPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self slidingViewControllerSetup];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Photo" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *dataSource = [NSArray arrayWithArray:[dict allValues]];
    self.arrayDataSource = [[ArrayDataSource alloc]initWithItems:dataSource cellIdentifier:@"Cell" configureCellBlock:^(TCDPhotoCollectionViewCell *cell, id item) {
        cell.imageView.image = [UIImage imageNamed:item];
    }];
    self.collectionView.dataSource = self.arrayDataSource;
    
    self.arrayDelegate = [[ArrayDelegate alloc]initWithDataSource:self.arrayDataSource sizeBlock:^CGSize(TCDPhotoCollectionViewCell *cell, id item, UICollectionView *collectionView, UICollectionViewFlowLayout *collectionViewLayout, NSIndexPath *indexPath) {
        UIImage *image = [UIImage imageNamed:item];
        
        return CGSizeMake(image.size.width * kDefaultCellHeight / image.size.height, kDefaultCellHeight);
    } selectBlock:^(TCDPhotoCollectionViewCell *cell, id item, UICollectionView *collectionView, NSIndexPath *indexPath) {
        self.photoGalleryViewController = [[UIPhotoGalleryViewController alloc]init];
        self.photoGalleryViewController.dataSource = self;
        self.photoGalleryViewController.showStatusBar = YES;
        self.photoGalleryViewController.initialIndex = indexPath.item;
        self.photoGalleryViewController.vPhotoGallery.initialIndex = indexPath.item;
        [self.navigationController pushViewController:self.photoGalleryViewController animated:YES];
    }];
    self.collectionView.delegate = self.arrayDelegate;
    // Do any additional setup after loading the view.
}

- (NSString*)pathWithFilename:(NSString*)name
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.plist", [NSBundle mainBundle], name];
    
    return filePath;
}

#pragma mark - PhotoGalleryDataSource

- (NSInteger)numberOfViewsInPhotoGallery:(UIPhotoGalleryView *)photoGallery
{
    return [self.arrayDataSource.items count];
}

- (UIImage *)photoGallery:(UIPhotoGalleryView *)photoGallery localImageAtIndex:(NSInteger)index
{
    return [UIImage imageNamed:self.arrayDataSource.items[index]];
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
