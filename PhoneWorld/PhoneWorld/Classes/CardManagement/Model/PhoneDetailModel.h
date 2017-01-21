//
//  PhoneDetailModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/5.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PhoneDetailModel : JSONModel

@property (nonatomic) NSString *cityName;
@property (nonatomic) NSString *number;
@property (nonatomic) NSString *numberStatus;
@property (nonatomic) NSString *operatorName;
@property (nonatomic) int org_number_poolsId;//号码池id
@property (nonatomic) NSArray *packages;//套餐
@property (nonatomic) NSString *prestore;//预存金额
@property (nonatomic) NSString *simICCID;//sim卡的ICCID
@property (nonatomic) int simId;

@end
