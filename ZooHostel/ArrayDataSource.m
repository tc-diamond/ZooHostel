//
//  ArrayDataSource.m
//  Art
//
//  Created by Eugene Tulushev on 14.03.14.
//  Copyright (c) 2014 e-Legion, LLC. All rights reserved.
//

#import "ArrayDataSource.h"

@interface ArrayDataSource ()

@property (nonatomic) BOOL itemsAreSections;

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSString *headerIdentifier;
@property (nonatomic, copy) NSString *footerIdentifier;

@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock;
@property (nonatomic, copy) CollectionViewCellConfigureBlock configureHeaderBlock;
@property (nonatomic, copy) CollectionViewCellConfigureBlock configureFooterBlock;

@end


@implementation ArrayDataSource

#pragma mark - Loading

- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(CollectionViewCellConfigureBlock)configureCellBlock
{
    return [self initWithItems:items itemsAreSections:NO cellIdentifier:cellIdentifier headerIdentifier:nil footerIdentifier:nil configureCellBlock:configureCellBlock configureHeaderBlock:nil configureFooterBlock:nil];
}

- (id)initWithItems:(NSArray *)items itemsAreSections:(BOOL)itemsAreSections cellIdentifier:(NSString *)cellIdentifier headerIdentifier:(NSString *)headerIdentifier footerIdentifier:(NSString *)footerIdentifier configureCellBlock:(CollectionViewCellConfigureBlock)configureCellBlock configureHeaderBlock:(CollectionViewCellConfigureBlock)configureHeaderBlock configureFooterBlock:(CollectionViewCellConfigureBlock)configureFooterBlock
{
    self = [super init];
    
    self.items = items;
    self.itemsAreSections = itemsAreSections;
    
    self.cellIdentifier = cellIdentifier;
    self.headerIdentifier = headerIdentifier;
    self.footerIdentifier = footerIdentifier;
    
    self.configureCellBlock = configureCellBlock;
    self.configureHeaderBlock = configureHeaderBlock;
    self.configureFooterBlock = configureFooterBlock;
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemsAreSections)
    {
        return self.items[indexPath.section][indexPath.row];
    }
    else
    {
        return self.items[indexPath.row];
    }
}

#pragma mark - Getting Item and Section Metrics

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.itemsAreSections)
    {
        NSUInteger itemsCount = [self.items[section] count];
        return itemsCount;
    }
    else
    {
        return self.items.count;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.itemsAreSections)
    {
        return self.items.count;
    }
    else
    {
        return 1;
    }
}

#pragma mark - Getting Views for Items

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier
                                                                           forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}



//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *reuseIdentifier;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//        reuseIdentifier = self.headerIdentifier;
//    }
//    else
//    {
//        reuseIdentifier = self.footerIdentifier;
//    }
//    
//    if (!reuseIdentifier) {
//        return nil;
//    }
//    
//    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    
//    id item = [self itemAtIndexPath:indexPath];
//    
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//        self.configureHeaderBlock(reusableView, item);
//    }
//    else
//    {
//        self.configureFooterBlock(reusableView, item);
//    }
//    
//    return reusableView;
//}

@end
