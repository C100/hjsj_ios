//
//  HomeViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) SDCycleScrollView *imageScrollView;
@property (nonatomic) UILabel *fastRoadLB;
@property (nonatomic) UIView *lineView;
@property (nonatomic) UICollectionView *fastCollectionView;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) NSArray *imageNames;
@property (nonatomic) NSArray *titleNames;

@end

@implementation HomeViewController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self imageScrollView];
    [self lineView];
    [self fastRoadLB];
    [self imageNames];
    [self titleNames];
    [self fastCollectionView];
    [self flowLayout];
}

#pragma mark - SDCycleScrollView Delegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"选中的轮播图下标%ld",index);
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
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%f",(self.fastCollectionView.height - 1)/2);
    return CGSizeMake((screenWidth-2)/3, (self.fastCollectionView.height - 1)/2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

#pragma mark - LazyLoading
- (SDCycleScrollView *)imageScrollView{
    if (_imageScrollView == nil) {
        /*--网络接口--*/
//        _imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
//        _imageScrollView.imageURLStringsGroup =
        /*--本地图片--*/
        _imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screenWidth, 180) imageNamesGroup:@[@"banner",@"banner",@"banner"]];
        [self.view addSubview:_imageScrollView];
        _imageScrollView.currentPageDotColor = MainColor;
    }
    return _imageScrollView;
}

- (UILabel *)fastRoadLB{
    if (_fastRoadLB == nil) {
        _fastRoadLB = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 - 50 , 190, 100, 18)];
        _fastRoadLB.text = @"快捷通道";
        _fastRoadLB.textColor = MainColor;
        _fastRoadLB.textAlignment = NSTextAlignmentCenter;
        _fastRoadLB.font = [UIFont systemFontOfSize:16];
        _fastRoadLB.backgroundColor = COLOR_BACKGROUND;
        [self.view addSubview:_fastRoadLB];
    }
    return _fastRoadLB;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 1)];
        _lineView.backgroundColor = MainColor;
        _lineView.alpha = 0.3;
        [self.view addSubview:_lineView];
    }
    return _lineView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (UICollectionView *)fastCollectionView{
    if (_fastCollectionView == nil) {
        _fastCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _fastCollectionView.bounces = NO;
        _fastCollectionView.delegate = self;
        _fastCollectionView.dataSource = self;
        _fastCollectionView.backgroundColor = COLOR_BACKGROUND;
        [_fastCollectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_fastCollectionView];
        [_fastCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(222);
            make.left.right.equalTo(0);
            make.bottom.equalTo(-74);
        }];
    }
    return _fastCollectionView;
}

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
