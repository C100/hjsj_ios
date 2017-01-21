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
#import "TransferCardViewController.h"
#import "FinishCardViewController.h"//成卡开户
#import "WhiteCardViewController.h"//白卡开户
#import "CardRepairViewController.h"//补卡

#define sc 254/375.0  //首页轮播图 高／宽
#define cv 260/375.0  //collectionView  高／宽

#define hw 312.0/375.0//开户量高／宽

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
//            self.imageNames = @[@"home1",@"home2",@"home3",@"home4",@"home5",@"home6"];
//            self.titleNames = @[@"话费充值",@"账户充值",@"过户",@"成卡开户",@"白卡开户",@"补卡"];
            //暂时把白卡开户的隐藏
            self.imageNames = @[@"home1",@"home2",@"home3",@"home4",@"home6"];
            self.titleNames = @[@"话费充值",@"账户充值",@"过户",@"成卡开户",@"补卡"];

            
            self.bounces = NO;
            [self imageScrollView];
            
            //暂时不区分用户等级
//            [self lineView];
//            [self fastRoadLB];
//            [self fastCollectionView];
            
            //区分用户等级
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *grade = [ud objectForKey:@"grade"];
            if ([grade isEqualToString:@"lev1"] || [grade isEqualToString:@"lev2"]) {
                //代理商 功能少
                
                [self countView];
                
            }else if([grade isEqualToString:@"lev3"]){
                //渠道商  功能多
                
                [self lineView];
                [self fastRoadLB];
                [self fastCollectionView];
            }else{
                //lev0 总 话机最高帐号
                [self lineView];
                [self fastRoadLB];
                [self fastCollectionView];
            }
        }
    }
    return self;
}

- (CountView *)countView{
    if (_countView == nil) {
        _countView = [[[CountView alloc] init]initWithFrame:CGRectMake(0, 200, 200, 200) andTitle:@"开户量"];
        [self addSubview:_countView];
        [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.mas_equalTo(self.imageScrollView.mas_bottom).mas_equalTo(10);

            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(screenWidth * hw + 20);
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(0);
        }];
        
    }
    return _countView;
}


#pragma mark - LazyLoading
- (SDCycleScrollView *)imageScrollView{
    if (_imageScrollView == nil) {        
        _imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
        _imageScrollView.contentMode = UIViewContentModeScaleAspectFit;
        _imageScrollView.backgroundColor = COLOR_BACKGROUND;
        [self addSubview:_imageScrollView];
        _imageScrollView.autoScrollTimeInterval = 3.0;
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
        _fastRoadLB.font = [UIFont systemFontOfSize:textfont14];
        _fastRoadLB.backgroundColor = COLOR_BACKGROUND;
        [self addSubview:_fastRoadLB];
        [_fastRoadLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(25);
            make.top.mas_equalTo(self.imageScrollView.mas_bottom).mas_equalTo(7);
        }];
    }
    return _fastRoadLB;
}

- (UICollectionView *)fastCollectionView{
    if (_fastCollectionView == nil) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _fastCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, screenWidth*sc+42, screenWidth, screenWidth*cv + 10) collectionViewLayout:self.flowLayout];
        _fastCollectionView.bounces = NO;
        _fastCollectionView.backgroundColor = COLOR_BACKGROUND;
        _fastCollectionView.delegate = self;
        _fastCollectionView.dataSource = self;
        [_fastCollectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_fastCollectionView];
        [_fastCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.fastRoadLB.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(screenWidth*cv + 10);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
        }];
    }
    return _fastCollectionView;
}

#pragma mark - SDCycleScrollView Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    _HomeHeadScrollCallBack(index);
}

#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    cell.titleLb.text = self.titleNames[indexPath.row];
    
    //圆角与阴影并存
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.contentView.layer.cornerRadius = 10.0f;
    
    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.layer.shadowRadius = 3.0f;
    cell.layer.shadowOpacity = 0.5f;//0－1  透明－不透明
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (screenWidth-44)/3.0;
    CGFloat height = width*120/112.0;
    
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 9;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 9;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    UIViewController *viewCon = [self viewController];
    switch (indexPath.row) {
        case 0:
        {
            NSInteger i0 = [ud integerForKey:@"phoneRecharge"];
            i0 = i0 + 1;
            [ud setInteger:i0 forKey:@"phoneRecharge"];
            [ud synchronize];
            TopCallMoneyViewController *vc = [TopCallMoneyViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            NSInteger i1 = [ud integerForKey:@"accountRecharge"];
            i1 = i1 + 1;
            [ud setInteger:i1 forKey:@"accountRecharge"];
            [ud synchronize];
            CheckAndTopViewController *vc = [CheckAndTopViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            NSInteger i2 = [ud integerForKey:@"transform"];
            i2 = i2 + 1;
            [ud setInteger:i2 forKey:@"transform"];
            [ud synchronize];
            TransferCardViewController *vc = [TransferCardViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            NSInteger i3 = [ud integerForKey:@"renewOpen"];
            i3 = i3 + 1;
            [ud setInteger:i3 forKey:@"renewOpen"];
            [ud synchronize];
            FinishCardViewController *vc = [FinishCardViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
//            NSInteger i4 = [ud integerForKey:@"replace"];
//            i4 = i4 + 1;
//            [ud setInteger:i4 forKey:@"replace"];
//            [ud synchronize];
//            WhiteCardViewController *vc = [WhiteCardViewController new];
//            vc.hidesBottomBarWhenPushed = YES;
//            [viewCon.navigationController pushViewController:vc animated:YES];
            //白卡隐藏
            CardRepairViewController *vc = [CardRepairViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [viewCon.navigationController pushViewController:vc animated:YES];

        }
            break;
//        case 5:
//        {
//            CardRepairViewController *vc = [CardRepairViewController new];
//            vc.hidesBottomBarWhenPushed = YES;
//            [viewCon.navigationController pushViewController:vc animated:YES];
//        }
//            break;
    }
}

@end
