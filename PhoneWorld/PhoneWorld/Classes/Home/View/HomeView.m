//
//  HomeView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "HomeView.h"
#import "HomeCell.h"

#define sc 180/433.0  //首页轮播图 高／宽

#define cv 301/375.0

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
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
            
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, screenWidth*sc + 20, screenWidth, 1)];
            _lineView.backgroundColor = MainColor;
            _lineView.alpha = 0.3;
            [self.container addSubview:_lineView];
            
            _fastRoadLB = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 - 50 , screenWidth*sc + 10, 100, 18)];
            _fastRoadLB.text = @"快捷通道";
            _fastRoadLB.textColor = MainColor;
            _fastRoadLB.textAlignment = NSTextAlignmentCenter;
            _fastRoadLB.font = [UIFont systemFontOfSize:16];
            _fastRoadLB.backgroundColor = COLOR_BACKGROUND;
            [self.container addSubview:_fastRoadLB];
            
            _imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screenWidth, screenWidth*sc) imageNamesGroup:@[@"banner",@"banner",@"banner"]];
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
