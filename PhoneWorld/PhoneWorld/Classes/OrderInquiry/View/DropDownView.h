//
//  DropDownView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownView : UIView <CalendarViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) void(^DropDownCallBack)(NSInteger tag);

//不同title不同状态
@property (nonatomic) NSArray *states;

//时间
@property (nonatomic) UILabel *timeLB;
@property (nonatomic) UITextField *beginTime;
@property (nonatomic) UIView *v;
@property (nonatomic) UITextField *endTime;

//状态
@property (nonatomic) UILabel *stateLB;
@property (nonatomic) UITextField *stateTF;
@property (nonatomic) UITableView *stateTableView;

//手机号
@property (nonatomic) UILabel *phoneLB;
@property (nonatomic) UITextField *phoneTF;
@property (nonatomic) UIButton *phoneShowBtn;
@property (nonatomic) UITableView *topStateTableView;//充值类型表格

//查询
@property (nonatomic) UIButton *findBtn;
//重置
@property (nonatomic) UIButton *resetBtn;

//日历
@property (nonatomic) CJCalendarViewController *calendarViewController;

@end
