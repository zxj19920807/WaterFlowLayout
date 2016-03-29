//
//  ZXJFlowLayout.h
//  瀑布流
//
//  Created by 张学军 on 16/3/19.
//  Copyright © 2016年 张学军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXJFlowLayout;

@protocol ZXJFlowLayoutDelegate <NSObject>

@required


- (CGFloat)zxjFlowLayout_heightForItemInLayout:(ZXJFlowLayout *)layout;

/**
 *  仿照tableView设计代理方法
 */
@optional

/**
 *  列数由代理方法指定,如果有指定并且>0,用指定的列数,否则用默认的
 *
 *  @param layout <#layout description#>
 *
 *  @return 列数
 */
- (NSInteger)zxjFlowLayout_numberOfColumnInLayout:(ZXJFlowLayout *)layout;


/**
 *  由外部指定edgeInsets
 *
 *  @param layout <#layout description#>
 *
 *  @return edgeInsets
 */
- (UIEdgeInsets)zxjFlowLayout_edgeInsetsOfLayout:(ZXJFlowLayout *)layout;



@end

@interface ZXJFlowLayout : UICollectionViewLayout

@property(nonatomic,assign)id<ZXJFlowLayoutDelegate>delegate;

@property(nonatomic,assign)CGFloat lineHeight;//行高（间隔）

@property(nonatomic,assign)CGFloat columnWidth;//列宽（间隔）

@end
