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

#define sc 254/375.0  //首页轮播图 高／宽

#define cv 260/375.0

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
            [self imageNames];
            [self titleNames];
            _scrollView = [[UIScrollView alloc] init];
            _scrollView.showsVerticalScrollIndicator = NO;
            _scrollView.bounces = NO;
            _scrollView.pagingEnabled = NO;
            [self addSubview:_scrollView];
            [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.top.equalTo(self);
                make.width.mas_equalTo(screenWidth);
                make.height.mas_equalTo(screenHeight-64-44);
            }];
            
            _container=[[UIView alloc] init];
            [_scrollView addSubview:_container];
            [_container mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(_scrollView);
                make.width.mas_equalTo(_scrollView.mas_width);
            }];
            
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, screenWidth*sc + 20, screenWidth - 20, 1)];
            _lineView.backgroundColor = [Utils colorRGB:@"#ec6c00"];
            _lineView.alpha = 0.3;
            [self.container addSubview:_lineView];
            
            _fastRoadLB = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 - 50 , screenWidth*sc + 12, 100, 18)];
            _fastRoadLB.text = @"快捷通道";
            _fastRoadLB.textColor = MainColor;
            _fastRoadLB.textAlignment = NSTextAlignmentCenter;
            _fastRoadLB.font = [UIFont systemFontOfSize:14];
            _fastRoadLB.backgroundColor = COLOR_BACKGROUND;
            [self.container addSubview:_fastRoadLB];
            
            _imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screenWidth, screenWidth*sc) imageNamesGroup:@[@"banner",@"banner",@"banner"]];
            _imageScrollView.delegate = self;
            [self.container addSubview:_imageScrollView];
            _imageScrollView.currentPageDotColor = MainColor;
            [_imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_container);
                make.top.equalTo(_container);
                make.width.equalTo(_container);
                make.height.mas_equalTo(screenWidth*sc);
            }];
            
            _flowLayout = [[UICollectionViewFlowLayout alloc] init];
            
            _fastCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
            _fastCollectionView.bounces = NO;
            _fastCollectionView.backgroundColor = COLOR_BACKGROUND;
            _fastCollectionView.delegate = self;
            _fastCollectionView.dataSource = self;
            [_fastCollectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"cell"];
            [self.container addSubview:_fastCollectionView];
            [_fastCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_imageScrollView.mas_bottom).with.offset(42);
                make.left.right.equalTo(_container);
                make.height.mas_equalTo(screenWidth*cv);
            }];
            
            [_container mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_fastCollectionView.mas_bottom);
            }];
            
        }
    }
    return self;
}

#pragma mark - SDCycleScrollView Delegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"~~~~~~~~~选中的轮播图下标%ld",(long)index);
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
            
        }
            break;
    }
}

#pragma mark - LazyLoading

- (NSArray *)imageNames{
    if (_imageNames == nil) {
        _imageNames = @[@"home1",@"home2",@"home3",@"home4",@"home5",@"home6"];
    }
    return _imageNames;
}

- (NSArray *)titleNames{
    if (_titleNames == nil) {
        _titleNames = @[@"话费充值",@"余额充值",@"余额查询",@"成卡开户",@"白卡开户",@"补卡"];
    }
    return _titleNames;
}


@end
