//
//  ChoosePackageTableView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"
#import "NormalTableViewCell.h"
#import "PhoneDetailModel.h"

#import "IMSIModel.h"

@interface ChoosePackageTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) InputView *inputView;//金额信息
@property (nonatomic) NormalTableViewCell *currentCell;

@property (nonatomic) NSArray *packagesDic;//所有套餐
@property (nonatomic) NSDictionary *currentDic;//当前选中套餐
@property (nonatomic) NSDictionary *currentPromotionDic;//当前选中活动包

@property (nonatomic) PhoneDetailModel *detailModel;

@property (nonatomic) IMSIModel *imsiModel;

@end
