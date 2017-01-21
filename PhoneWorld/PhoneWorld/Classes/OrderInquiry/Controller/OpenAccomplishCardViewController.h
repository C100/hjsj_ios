//
//  OpenAccomplishCardViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderView.h"

@interface OpenAccomplishCardViewController : UIViewController

+ (OpenAccomplishCardViewController *)sharedOpenAccomplishCardViewController;
@property (nonatomic) OrderView *orderView;
@property (nonatomic) NSMutableArray *orderModelsArr;

//查询条件
@property (nonatomic) NSArray *inquiryConditionArray;

@end
