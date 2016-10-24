//
//  WhiteCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhiteCardTopView.h"
#import "WhiteCardFilterView.h"

@interface WhiteCardView : UIScrollView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UIView *siftView;
@property (nonatomic) WhiteCardTopView *topView;
@property (nonatomic) WhiteCardFilterView *selectView;
@property (nonatomic) UICollectionView *contentView;

@end
