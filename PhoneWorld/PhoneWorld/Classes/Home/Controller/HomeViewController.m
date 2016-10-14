//
//  HomeViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "HomeView.h"
#import "TopCallMoneyViewController.h"  //话费充值
#import "CheckAndTopViewController.h"  //余额查询与充值

#import "MessageViewController.h"
#import "PersonalHomeViewController.h"

#define homeCellWH 125/152.0

@interface HomeViewController ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSArray *imageNames;
@property (nonatomic) NSArray *titleNames;

@property (nonatomic) HomeView *homeView;

@end

@implementation HomeViewController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"individualCenter"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoPersonalHomeVC)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"news_white"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMessagesVC)];

    
    [self imageNames];
    [self titleNames];
    _homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 44)];
    _homeView.fastCollectionView.delegate = self;
    _homeView.fastCollectionView.dataSource = self;
    _homeView.imageScrollView.delegate = self;
    [self.view addSubview:self.homeView];
}

#pragma mark - Method
- (void)gotoMessagesVC{
    MessageViewController *messageVC = [MessageViewController new];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)gotoPersonalHomeVC{
    PersonalHomeViewController *vc = [PersonalHomeViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (screenWidth-2)/3;
    CGFloat height = width*152/125.0;
    
    return CGSizeMake(width, height-1);
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            TopCallMoneyViewController *vc = [TopCallMoneyViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            CheckAndTopViewController *vc = [CheckAndTopViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            CheckAndTopViewController *vc = [CheckAndTopViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
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
