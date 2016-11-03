//
//  HomeView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

//筛选view
@interface HomeView : UIScrollView<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UIView *container;//所有内容加到这个view中

@property (nonatomic) SDCycleScrollView *imageScrollView;//首页轮播图

@property (nonatomic) UILabel *fastRoadLB;//快速通道
@property (nonatomic) UIView *lineView;//黄色分割线

@property (nonatomic) UICollectionView *fastCollectionView;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;

@end
