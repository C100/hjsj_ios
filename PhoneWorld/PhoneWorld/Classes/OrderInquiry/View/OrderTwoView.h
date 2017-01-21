//
//  OrderTwoView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTwoTableViewCell.h"

@interface OrderTwoView : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *orderTwoTableView;
@property (nonatomic) UILabel *resultNumLB;

@property (nonatomic) NSMutableArray *orderListArray;

@end
