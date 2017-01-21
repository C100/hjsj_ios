//
//  ChoosePackageView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosePackageTableView.h"
#import "PhoneDetailModel.h"

@interface ChoosePackageView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic) ChoosePackageTableView *tableView;
@property (nonatomic) UIButton *nextButton;

@property (nonatomic) PhoneDetailModel *detailModel;

@end
