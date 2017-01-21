//
//  TopUpViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTwoView.h"

@interface TopUpViewController : UIViewController
+ (TopUpViewController *)sharedTopUpViewController;
@property (nonatomic) OrderTwoView *orderTwoView;
@property (nonatomic) NSMutableArray *rechargeListArray;

//查询条件
@property (nonatomic) NSArray *inquiryConditionArray;

@end
