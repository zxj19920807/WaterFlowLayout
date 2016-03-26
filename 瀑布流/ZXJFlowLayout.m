//
//  ZXJFlowLayout.m
//  瀑布流
//
//  Created by 张学军 on 16/3/19.
//  Copyright © 2016年 张学军. All rights reserved.
//

#import "ZXJFlowLayout.h"


static const NSInteger ZXJDefaultColumn = 3;

@interface ZXJFlowLayout ()


@property(nonatomic,strong)NSMutableArray *columnHeights;

@property(nonatomic,strong)NSMutableArray *attrs;

@property(nonatomic,assign)NSInteger AllHeight;


- (UIEdgeInsets)edgeInsets;

@end

@implementation ZXJFlowLayout

- (UIEdgeInsets)edgeInsets {
    UIEdgeInsets insets = {20,10,20,10};
    return insets;
}


- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrs {
    if (!_attrs) {
        _attrs = [NSMutableArray array];
    }
    return _attrs;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    
    
    [self.columnHeights removeAllObjects];
    for (int i = 0 ; i < ZXJDefaultColumn; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    
    [self.attrs removeAllObjects];
    
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0 ; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrs addObject:attr];
    }
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat itemW = (self.collectionView.frame.size.width - self.edgeInsets.left -  self.edgeInsets.right - (ZXJDefaultColumn-1)*10)/ZXJDefaultColumn;
    
    CGFloat itemH = arc4random_uniform(50) + 100;
    
    NSInteger minColumn = 0;
    
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    
    for (int i = 0; i < ZXJDefaultColumn; i++) {
        if (minColumnHeight > [self.columnHeights[i] doubleValue]) {
            minColumn = i;
            minColumnHeight = [self.columnHeights[i] doubleValue];
        }
    }
    
    
    CGFloat X = self.edgeInsets.left + (itemW + 10)*minColumn;
    
    CGFloat Y = minColumnHeight;
    if (Y != self.edgeInsets.top) {
        Y = Y + 10 ;
    }

    
    attri.frame = CGRectMake(X, Y, itemW, itemH);
    
    self.columnHeights[minColumn] = @(CGRectGetMaxY(attri.frame));
    
    
    //
    CGFloat allcount = [self.columnHeights[minColumn] doubleValue];
    if (allcount > _AllHeight) {
        _AllHeight = allcount;
    }
    
    
    return attri;
    
    
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.edgeInsets.bottom + _AllHeight);
}


@end
