//
//  ZXJFlowLayout.m
//  瀑布流
//
//  Created by 张学军 on 16/3/19.
//  Copyright © 2016年 张学军. All rights reserved.
//

#import "ZXJFlowLayout.h"


static const NSInteger ZXJDefaultColumn = 3;//默认列数

static const UIEdgeInsets ZXJDefaultEdgeInsets = {20,10,20,10};//默认偏移


@interface ZXJFlowLayout ()


@property(nonatomic,strong)NSMutableArray *columnHeights;

@property(nonatomic,strong)NSMutableArray *attrs;

@property(nonatomic,assign)NSInteger AllHeight;


- (UIEdgeInsets)edgeInsets;//偏移

- (NSInteger)columnCount;//列数

@end

@implementation ZXJFlowLayout

- (UIEdgeInsets)edgeInsets {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(zxjFlowLayout_edgeInsetsOfLayout:)]) {
          UIEdgeInsets insets = [self.delegate zxjFlowLayout_edgeInsetsOfLayout:self];
        return insets;
    }
    return ZXJDefaultEdgeInsets;
}

- (NSInteger)columnCount {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zxjFlowLayout_numberOfColumnInLayout:)]) {
        if ([self.delegate zxjFlowLayout_numberOfColumnInLayout:self]) {
            return [self.delegate zxjFlowLayout_numberOfColumnInLayout:self];
        } else {
            return ZXJDefaultColumn;
        }
    } else {
        return ZXJDefaultColumn;
    }
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
    for (int i = 0 ; i < self.columnCount; i++) {
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
    
    CGFloat itemW = (self.collectionView.frame.size.width - self.edgeInsets.left -  self.edgeInsets.right - (self.columnCount-1)*self.columnWidth)/self.columnCount;
    
    CGFloat itemH = [self.delegate zxjFlowLayout_heightForItemInLayout:self];
    
    NSInteger minColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    
    for (int i = 0; i < self.columnCount; i++) {
        if (minColumnHeight > [self.columnHeights[i] doubleValue]) {
            minColumn = i;
            minColumnHeight = [self.columnHeights[i] doubleValue];
        }
    }
    
    
    CGFloat X = self.edgeInsets.left + (itemW + self.columnWidth)*minColumn;
    
    CGFloat Y = minColumnHeight;
    if (Y != self.edgeInsets.top) {
        Y = Y + self.lineHeight ;
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
