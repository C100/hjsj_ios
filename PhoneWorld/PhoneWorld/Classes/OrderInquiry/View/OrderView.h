//
//  OrderTableView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTableViewCell.h"

@interface OrderView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) void(^OrderViewCallBack)(NSInteger section);
@property (nonatomic) UITableView *orderTableView;
@property (nonatomic) UILabel *resultNumLB;
@property (nonatomic) NSArray *titles;

@property (nonatomic) NSMutableArray *orderListArray;

@end
