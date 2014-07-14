//
//  ArrayDataSource.h
//  Art
//
//  Created by Eugene Tulushev on 14.03.14.
//  Copyright (c) 2014 e-Legion, LLC. All rights reserved.
//

typedef void (^CollectionViewCellConfigureBlock)(id cell, id item);

@interface ArrayDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *items;

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(CollectionViewCellConfigureBlock)configureCellBlock;

- (id)initWithItems:(NSArray *)items itemsAreSections:(BOOL)itemsAreSections cellIdentifier:(NSString *)cellIdentifier headerIdentifier:(NSString *)headerIdentifier footerIdentifier:(NSString *)footerIdentifier configureCellBlock:(CollectionViewCellConfigureBlock)configureCellBlock configureHeaderBlock:(CollectionViewCellConfigureBlock)configureHeaderBlock configureFooterBlock:(CollectionViewCellConfigureBlock)configureFooterBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
