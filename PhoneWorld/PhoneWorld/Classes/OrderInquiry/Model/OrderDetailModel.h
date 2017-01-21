//
//  OrderDetailModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/3.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface OrderDetailModel : JSONModel

@property (nonatomic) NSString *orderNo;//订单号
@property (nonatomic) NSString *orderStatus;//订单状态
@property (nonatomic) NSString *authenticationType;//开户方式
@property (nonatomic) NSString *createDate;//
@property (nonatomic) NSString *cardType;//开户类型
@property (nonatomic) NSString *acceptUser;//
@property (nonatomic) NSString *acceptChannel;//
@property (nonatomic) NSString *number;//
@property (nonatomic) NSString *iccid;//
@property (nonatomic) NSString *operatorname;//
@property (nonatomic) NSString *network;//网络制式
@property (nonatomic) NSString *province;//
@property (nonatomic) NSString *city;//
@property (nonatomic) NSString *isLiang;//
@property (nonatomic) NSString *prestore;//
@property (nonatomic) NSString *promotion;//
@property (nonatomic) NSString *packagename;//
@property (nonatomic) NSURL *photoFront;//
@property (nonatomic) NSURL *photoBack;//
@property (nonatomic) NSString *certificatesType;//证件类型
@property (nonatomic) NSString *certificatesNo;//
@property (nonatomic) NSString *customerName;//
@property (nonatomic) NSString *address;//

@property (nonatomic) NSString<Optional> *updateDate;//审核时间
@property (nonatomic) NSString<Optional> *startTime;//审核结果

@end
