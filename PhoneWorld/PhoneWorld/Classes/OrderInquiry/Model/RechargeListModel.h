//
//  RechargeListModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/3.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RechargeListModel : JSONModel

//充值model
@property (nonatomic) NSString *orderNo;
@property (nonatomic) NSString *number;
@property (nonatomic) NSString *payAmount;
@property (nonatomic) NSString *rechargeDate;
@property (nonatomic) NSString *startTime;
@property (nonatomic) NSString<Optional> *startName;

@end
