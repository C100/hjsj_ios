//
//  FilterView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterView : UIView <UITableViewDelegate, UITableViewDataSource, CalendarViewControllerDelegate>

@property (nonatomic) UITableView *filterTableView;
@property (nonatomic) UITextField *phoneTF;//手机号输入框
@property (nonatomic) NSArray *orderStates;//订单状态
@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *details;
//查询
@property (nonatomic) UIButton *findBtn;
//重置
@property (nonatomic) UIButton *resetBtn;
//日历
@property (nonatomic) CJCalendarViewController *calendarViewController;
@end
