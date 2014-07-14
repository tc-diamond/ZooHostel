//
//  ArrayDelegate.m
//  Art
//
//  Created by Eugene Tulushev on 10.04.14.
//  Copyright (c) 2014 e-Legion, LLC. All rights reserved.
//

#import "ArrayDataSource.h"
#import "ArrayDelegate.h"

@interface ArrayDelegate ()

@property (nonatomic, strong) ArrayDataSource *dataSource;
@property (nonatomic, copy) CollectionViewCellSizeBlock sizeBlock;
@property (nonatomic, copy) CollectionViewCellSelectBlock selectBlock;

@end


@implementation ArrayDelegate

- (id)init
{
    return nil;
}

- (id)initWithDataSource:(ArrayDataSource *)dataSource
               sizeBlock:(CollectionViewCellSizeBlock)sizeBlock
             selectBlock:(CollectionViewCellSelectBlock)selectBlock
{
    self = [super init];
    
    self.dataSource = dataSource;
    self.sizeBlock = [sizeBlock copy];
    self.selectBlock = [selectBlock copy];
    
    return self;
}

#pragma mark - Cell Size

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewFlowLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self.dataSource itemAtIndexPath:indexPath];
    id cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.sizeBlock)
    {
        return self.sizeBlock(cell, item, collectionView, collectionViewLayout, indexPath);
    }
    else
    {
        return collectionViewLayout.itemSize;
    }
}

#pragma mark - Did Select

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self.dataSource itemAtIndexPath:indexPath];
    id cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.selectBlock)
    {
        self.selectBlock(cell, item, collectionView, indexPath);
    }
}

@end
