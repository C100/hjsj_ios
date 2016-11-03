//
//  OrderListModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface OrderListModel : JSONModel

@property (nonatomic) NSString *orderNo;//订单编号
@property (nonatomic) NSString *number;//手机号
@property (nonatomic) NSString *customerName;
@property (nonatomic) NSString *orderStatusName;

@end
