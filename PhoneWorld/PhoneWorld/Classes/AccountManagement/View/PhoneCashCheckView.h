//
//  OrderView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneCashCheckView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) void(^orderCallBack)(NSString *phoneNumber);

@property (nonatomic) UIButton *findButton;
@property (nonatomic) NSArray *userinfos;//传入查询结果
@property (nonatomic) UITableView *resultTableView;//显示查询结果

@end
