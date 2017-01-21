//
//  RepairCardViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderView.h"

@interface RepairCardViewController : UIViewController
+ (RepairCardViewController *)sharedRepairCardViewController;
@property (nonatomic) OrderView *orderView;
@property (nonatomic) NSMutableArray *cardRepairList;

//查询条件
@property (nonatomic) NSArray *inquiryConditionArray;

@end
