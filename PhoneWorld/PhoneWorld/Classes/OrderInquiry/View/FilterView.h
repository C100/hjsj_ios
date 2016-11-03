//
//  FilterView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

@interface FilterView : UIView <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) void(^FilterCallBack)(NSArray *array,NSString *string);
@property (nonatomic) void(^DismissPickerViewCallBack) (id obj);

@property (nonatomic) UITableView *filterTableView;
@property (nonatomic) NSArray *orderStates;//订单状态／订单类型
@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *details;

@property (nonatomic) UIButton *findBtn;//查询
@property (nonatomic) UIButton *resetBtn;//重置

@property (nonatomic) UIView *pickView;//灰色背景
@property (nonatomic) UIDatePicker *beginDatePicker;//时间选择器
@property (nonatomic) UIPickerView *pickerView;//订单状态等pickerView

@property (nonatomic) UIButton *closeImagePickerButton;//确定
@property (nonatomic) UIButton *cancelButton;//取消

@property (nonatomic) InputView *phoneInputView;//只要有手机号的就保存

@end
