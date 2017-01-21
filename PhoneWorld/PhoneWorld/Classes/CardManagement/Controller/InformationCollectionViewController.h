//
//  InformationCollectionViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneDetailModel.h"

#import "IMSIModel.h"

@interface InformationCollectionViewController : UIViewController

@property (nonatomic) BOOL isFinished;//是不是成卡开户

//成卡需要的
@property (nonatomic) PhoneDetailModel *detailModel;//成卡开户


//共有的
@property (nonatomic) NSDictionary *currentPackageDictionary;//套餐
@property (nonatomic) NSDictionary *currentPromotionDictionary;//活动包
@property (nonatomic) NSString *moneyString;//预存金额


//白卡需要的
@property (nonatomic) IMSIModel *imsiModel;//白卡开户
@property (nonatomic) NSString *iccidString;//白卡开户读卡读出来的iccid
@property (nonatomic) NSArray *infosArray;//白卡开户手机号等信息

@end
