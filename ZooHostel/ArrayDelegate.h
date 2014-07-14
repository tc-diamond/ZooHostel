//
//  ArrayDelegate.h
//  Art
//
//  Created by Eugene Tulushev on 10.04.14.
//  Copyright (c) 2014 e-Legion, LLC. All rights reserved.
//

typedef CGSize (^CollectionViewCellSizeBlock)(
                                                 id cell,
                                                 id item,
                                                 UICollectionView *collectionView,
                                                 UICollectionViewFlowLayout *collectionViewLayout,
                                                 NSIndexPath *indexPath
                                             );

typedef void (^CollectionViewCellSelectBlock)(
                                                 id cell,
                                                 id item,
                                                 UICollectionView *collectionView,
                                                 NSIndexPath *indexPath
                                             );

@class ArrayDataSource;

@interface ArrayDelegate : NSObject <UICollectionViewDelegateFlowLayout>

- (id)initWithDataSource:(ArrayDataSource *)dataSource
               sizeBlock:(CollectionViewCellSizeBlock)sizeBlock
             selectBlock:(CollectionViewCellSelectBlock)selectBlock;

@end
