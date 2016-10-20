//
//  HomeView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "HomeView.h"
#import "HomeCell.h"
#import "TopCallMoneyViewController.h"  //话费充值
#import "CheckAndTopViewController.h"  //余额查询与充值
#import "FinishCardViewController.h"//成卡开户
#import "WhiteCardViewController.h"//白卡开户
#import "CardRepairViewController.h"//补卡

#define sc 254/375.0  //首页轮播图 高／宽
#define cv 260/375.0  //collectionView  高／宽

@interface HomeView ()

@property (nonatomic) NSArray *imageNames;
@property (nonatomic) NSArray *titleNames;

@end

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
            self.imageNames = @[@"home1",@"home2",@"home3",@"home4",@"home5",@"home6"];
            self.titleNames = @[@"话费充值",@"余额充值",@"余额查询",@"成卡开户",@"白卡开户",@"补卡"];
            self.bounces = NO;
            [self imageScrollView];
            [self lineView];
            [self fastRoadLB];
            [self fastCollectionView];
        }
    }
    return self;
}

#pragma mark - LazyLoading
- (SDCycleScrollView *)imageScrollView{
    if (_imageScrollView == nil) {
        _imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageNamesGroup:@[@"banner",@"banner",@"banner"]];
        _imageScrollView.delegate = self;
        [self addSubview:_imageScrollView];
        _imageScrollView.currentPageDotColor = MainColor;
        [_imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(screenWidth*sc);
        }];
    }
    return _imageScrollView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [Utils colorRGB:@"#ec6c00"];
        _lineView.alpha = 0.3;
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(screenWidth - 20);
            make.top.mas_equalTo(self.imageScrollView.mas_bottom).mas_equalTo(20);
        }];
    }
    return _lineView;
}

- (UILabel *)fastRoadLB{
    if (_fastRoadLB == nil) {
        _fastRoadLB = [[UILabel alloc] initWithFrame:CGRectZero];
        _fastRoadLB.text = @"快捷通道";
        _fastRoadLB.textColor = MainColor;
        _fastRoadLB.textAlignment = NSTextAlignmentCenter;
        _fastRoadLB.font = [UIFont systemFontOfSize:14];
        _fastRoadLB.backgroundColor = COLOR_BACKGROUND;
        [self addSubview:_fastRoadLB];
        [_fastRoadLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(18);
            make.top.mas_equalTo(self.imageScrollView.mas_bottom).mas_equalTo(7);
        }];
    }
    return _fastRoadLB;
}

- (UICollectionView *)fastCollectionView{
    if (_fastCollectionView == nil) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _fastCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, screenWidth*sc+42, screenWidth, screenWidth*cv) collectionViewLayout:self.flowLayout];
        _fastCollectionView.bounces = NO;
        _fastCollectionView.backgroundColor = COLOR_BACKGROUND;
        _fastCollectionView.delegate = self;
        _fastCollectionView.dataSource = self;
        [_fastCollectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_fastCollectionView];
        [_fastCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.fastRoadLB.mas_bottom).mas_equalTo(7);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(screenWidth*cv);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
        }];
    }
    return _fastCollectionView;
}

#pragma mark - SDCycleScrollView Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"~~~~~~~~~首页选中的轮播图下标%ld",(long)index);
}

#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    cell.titleLb.text = self.titleNames[indexPath.row];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (screenWidth-44)/3.0;
    CGFloat height = width*120/112.0;
    
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *viewCon = [self viewController];
    switch (indexPath.row) {
        case 0:
        {
            TopCallMoneyViewController *vc = [TopCallMoneyViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            CheckAndTopViewController *vc = [CheckAndTopViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            CheckAndTopViewController *vc = [CheckAndTopViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            FinishCardViewController *vc = [FinishCardViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            WhiteCardViewController *vc = [WhiteCardViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            CardRepairViewController *vc = [CardRepairViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}

@end
