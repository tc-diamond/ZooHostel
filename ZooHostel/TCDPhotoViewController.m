//
//  TCDPhotoViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 13.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "ArrayDataSource.h"
#import "ArrayDelegate.h"
#import "TCDParser.h"
#import "TCDPhoto.h"
#import "TCDPhotoAlbum.h"
#import "TCDPhotoCollectionViewCell.h"
#import "TCDPhotoCollectionViewHeader.h"
#import "TCDPhotoViewController.h"
#import <RESideMenu/RESideMenu.h>
#import <UIImageView+AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

NSString * const kPhotoSegueIdentifier = @"PhotoSegueIdentifier";
static NSString * const TCDPhotoViewControllerPhotosURLString = @"http://cp9.megagroup.ru/d/683110/d/photos.txt";

@interface TCDPhotoViewController ()

@property (strong, nonatomic) ArrayDataSource *arrayDataSource;
@property (strong, nonatomic) ArrayDelegate *arrayDelegate;

@end

@implementation TCDPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *parsingString = [NSString stringWithContentsOfURL:[NSURL URLWithString:TCDPhotoViewControllerPhotosURLString] encoding:NSUTF8StringEncoding error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self fillWithParsingString:parsingString];
        });
    });
}

- (void)fillWithParsingString:(NSString *)parsingString
{
    NSArray *photos = [TCDParser photosFromParsingString:parsingString];
    
    
    self.arrayDataSource = [[ArrayDataSource alloc]initWithItems:photos cellIdentifier:@"Cell" configureCellBlock:^(TCDPhotoCollectionViewCell *cell, TCDPhoto *photo) {
        [cell.imageView setImageWithURL:photo.url];
        cell.contentView.frame = cell.bounds;
    }];
    self.collectionView.dataSource = self.arrayDataSource;
    
    self.arrayDelegate = [[ArrayDelegate alloc]initWithDataSource:self.arrayDataSource sizeBlock:^CGSize(TCDPhotoCollectionViewCell *cell, TCDPhoto *item, UICollectionView *collectionView, UICollectionViewFlowLayout *collectionViewLayout, NSIndexPath *indexPath) {
        
        if (indexPath.item == 16) {
            NSLog(@"break");
        }
        
        NSInteger nearestIndex = -1;//one in a row
        if (indexPath.item % 2 == 0 ) {
            //left item
            nearestIndex = indexPath.item + 1;
        } else {
            //right item
            nearestIndex = indexPath.item - 1;
        }
        
        CGSize size;
        
        if (nearestIndex >= self.arrayDataSource.items.count) {
            //out of items array
            size = CGSizeMake(collectionView.bounds.size.width, item.size.height * collectionView.bounds.size.width / item.size.width);
        } else {
            TCDPhoto *nearestImage = [self.arrayDataSource.items objectAtIndex:nearestIndex];
            CGSize currImageSize = item.size;
            CGSize nearestImageSize = nearestImage.size;
            CGFloat heightDiff = nearestImage.size.height / currImageSize.height;
            nearestImageSize.width /= heightDiff;
            nearestImageSize.height /= heightDiff;
            
            CGFloat sumWidth = currImageSize.width + nearestImageSize.width;
            CGFloat scale = sumWidth / collectionView.bounds.size.width;
            currImageSize.width = floorf(currImageSize.width);
            size = CGSizeMake(floorf(currImageSize.width  / scale) - 1,
                              floorf(currImageSize.height / scale) - 1);
        }
        
        return size;
    } selectBlock:^(TCDPhotoCollectionViewCell *cell, id item, UICollectionView *collectionView, NSIndexPath *indexPath) {
        
    }];
    self.collectionView.delegate = self.arrayDelegate;
    
    [SVProgressHUD dismiss];
}

#pragma mark - Navigation

- (IBAction)menuBarButtonTapped:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

@end
