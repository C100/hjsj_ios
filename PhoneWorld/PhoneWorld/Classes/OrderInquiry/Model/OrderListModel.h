//
//  OrderListModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface OrderListModel : JSONModel

//成卡开户白卡开户
@property (nonatomic) NSString *orderNo;//订单编号
@property (nonatomic) NSString *number;//手机号
@property (nonatomic) NSString *customerName;
@property (nonatomic) NSString *orderStatusName;
@property (nonatomic) NSString *startTime;//创建日期

@end
