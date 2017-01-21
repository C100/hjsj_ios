//
//  OrderTwoTableViewCell.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechargeListModel.h"

@interface OrderTwoTableViewCell : UITableViewCell

@property (nonatomic) UILabel *numberLB;
@property (nonatomic) UILabel *dateLB;
@property (nonatomic) UILabel *moneyLB;
@property (nonatomic) UILabel *phoneLB;
@property (nonatomic) UILabel *stateLB;
@property (nonatomic) RechargeListModel *rechargeModel;

@end
