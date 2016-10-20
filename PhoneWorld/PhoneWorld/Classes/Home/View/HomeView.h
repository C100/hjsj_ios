//
//  HomeView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

//筛选view
@interface HomeView : UIView<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *container;

@property (nonatomic) SDCycleScrollView *imageScrollView;

@property (nonatomic) UILabel *fastRoadLB;
@property (nonatomic) UIView *lineView;

@property (nonatomic) UICollectionView *fastCollectionView;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;

@end
