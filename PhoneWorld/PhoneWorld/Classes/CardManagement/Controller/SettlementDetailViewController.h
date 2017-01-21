//
//  SettlementDetailViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneDetailModel.h"
#import "IMSIModel.h"

@interface SettlementDetailViewController : UIViewController

@property (nonatomic) BOOL isFinished;//是不是成卡开户

@property (nonatomic) PhoneDetailModel *detailModel;//成卡开户
@property (nonatomic) BOOL isAuto;//自动获取还是手动获取 成卡开户才需要


@property (nonatomic) NSDictionary *currentPackageDictionary;
@property (nonatomic) NSDictionary *currentPromotionDictionary;
@property (nonatomic) NSDictionary *collectionInfoDictionary;//informationCollectionViewController界面收集的信息字典
@property (nonatomic) NSString *moneyString;


@property (nonatomic) IMSIModel *imsiModel;//白卡开户
@property (nonatomic) NSString *iccidString;//白卡开户读卡得到的iccid
@property (nonatomic) NSArray *infosArray;//白卡开户的到手机号信息

@end
