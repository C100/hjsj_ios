//
//  WhiteCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhiteCardView : UIScrollView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UIView *siftView;

@property (nonatomic) UICollectionView *contentView;

@end
