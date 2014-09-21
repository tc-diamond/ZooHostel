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
    
    NSString *parsingString = [NSString stringWithContentsOfURL:[NSURL URLWithString:TCDPhotoViewControllerPhotosURLString] encoding:NSUTF8StringEncoding error:nil];
    NSArray *photoAlbums = [TCDParser parseStringToPhotoAlbums:parsingString];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Photo" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *dataSource = [NSArray arrayWithArray:[dict allValues]];
    self.arrayDataSource = [[ArrayDataSource alloc]initWithItems:photoAlbums itemsAreSections:YES cellIdentifier:@"Cell" headerIdentifier:@"Header" footerIdentifier:nil configureCellBlock:^(TCDPhotoCollectionViewCell *cell, TCDPhoto *photo) {
        [cell.imageView setImageWithURL:photo.presentationUrl];
    } configureHeaderBlock:^(TCDPhotoCollectionViewHeader *cell, TCDPhotoAlbum *photoAlbum) {
        cell.titleLabel.text = photoAlbum.title;
    } configureFooterBlock:nil];
    self.arrayDataSource = [[ArrayDataSource alloc]initWithItems:dataSource cellIdentifier:@"Cell" configureCellBlock:^(TCDPhotoCollectionViewCell *cell, id item) {
        cell.imageView.image = [UIImage imageNamed:item];
    }];
    self.collectionView.dataSource = self.arrayDataSource;
    
    self.arrayDelegate = [[ArrayDelegate alloc]initWithDataSource:self.arrayDataSource sizeBlock:^CGSize(TCDPhotoCollectionViewCell *cell, id item, UICollectionView *collectionView, UICollectionViewFlowLayout *collectionViewLayout, NSIndexPath *indexPath) {
        UIImage *image = [UIImage imageNamed:item];
        
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
            size = CGSizeMake(collectionView.bounds.size.width, image.size.height * collectionView.bounds.size.width / image.size.width);
        } else {
            UIImage *nearestImage = [UIImage imageNamed:self.arrayDataSource.items[nearestIndex]];
            CGSize currImageSize = image.size;
            CGSize nearestImageSize = nearestImage.size;
            CGFloat heightDiff = nearestImage.size.height / currImageSize.height;
            nearestImageSize.width /= heightDiff;
            nearestImageSize.height /= heightDiff;
            
            CGFloat sumWidth = currImageSize.width + nearestImageSize.width;
            CGFloat scale = sumWidth / collectionView.bounds.size.width;
            currImageSize.width = floorf(currImageSize.width);
            size = CGSizeMake(currImageSize.width / scale - 1, floorf(currImageSize.height / scale) - 1);
        }
        
        return size;
    } selectBlock:^(TCDPhotoCollectionViewCell *cell, id item, UICollectionView *collectionView, NSIndexPath *indexPath) {
//        self.photoGalleryViewController = [[UIPhotoGalleryViewController alloc]init];
//        self.photoGalleryViewController.dataSource = self;
//        self.photoGalleryViewController.showStatusBar = YES;
//        self.photoGalleryViewController.initialIndex = indexPath.item;
//        self.photoGalleryViewController.vPhotoGallery.initialIndex = indexPath.item;
//        [self.navigationController pushViewController:self.photoGalleryViewController animated:YES];
    }];
    self.collectionView.delegate = self.arrayDelegate;
    // Do any additional setup after loading the view.
}

- (NSString*)pathWithFilename:(NSString*)name
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.plist", [NSBundle mainBundle], name];
    
    return filePath;
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
