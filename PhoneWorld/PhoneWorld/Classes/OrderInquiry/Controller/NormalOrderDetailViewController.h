//
//  NormalOrderViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface NormalOrderDetailViewController : UIViewController

@property (nonatomic) OrderListModel *orderModel;

@property (nonatomic) NSString *orderNo;//开户订单号

@end
