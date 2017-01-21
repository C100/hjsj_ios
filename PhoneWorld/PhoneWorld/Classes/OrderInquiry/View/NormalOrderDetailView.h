//
//  NormalOrderView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

#import "OrderListModel.h"

@interface NormalOrderDetailView : UIView<UIScrollViewDelegate>

@property (nonatomic) UIView *headView;
@property (nonatomic) UIView *moveView;//黄色下标
@property (nonatomic) UIScrollView *contentView;
@property (nonatomic) UIView *firstView;
@property (nonatomic) UIView *secondView;
@property (nonatomic) UIScrollView *thirdView;

@property (nonatomic) NSMutableArray *titleButtons;

@property (nonatomic) OrderDetailModel *detailModel;

@property (nonatomic) OrderListModel *orderModel;

@end
