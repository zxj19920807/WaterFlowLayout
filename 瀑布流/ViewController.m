//
//  ViewController.m
//  瀑布流
//
//  Created by 张学军 on 16/3/18.
//  Copyright © 2016年 张学军. All rights reserved.
//

#import "ViewController.h"
#import "ZXJFlowLayout.h"



static NSString *cellId = @"cellID";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ZXJFlowLayoutDelegate>



@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    ZXJFlowLayout *layout = [[ZXJFlowLayout alloc] init];
    layout.delegate = self;
    layout.lineHeight = 0;
    layout.columnWidth = 20;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
    
}

//指定每一列的高度
- (CGFloat)zxjFlowLayout_heightForItemInLayout:(ZXJFlowLayout *)layout {
    return arc4random_uniform(100) + 50;
}

//代理指定列数
- (NSInteger)zxjFlowLayout_numberOfColumnInLayout:(ZXJFlowLayout *)layout {
    return 4;
}

//代理指定edgeInsets

- (UIEdgeInsets)zxjFlowLayout_edgeInsetsOfLayout:(ZXJFlowLayout *)layout {
    UIEdgeInsets edgeInsets = {50,40,50,40};
    return edgeInsets;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0  blue:arc4random_uniform(255)/255.0  alpha:1];
    
    //创建一个tag label从tag中取  如果不存在就创建 这样就能达到重用池效果
    NSInteger tag = 10;
    UILabel *label = [cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        [cell.contentView addSubview:label];
    }
    label.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    label.textAlignment = NSTextAlignmentCenter;;
    label.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    

    return cell;
}





@end
