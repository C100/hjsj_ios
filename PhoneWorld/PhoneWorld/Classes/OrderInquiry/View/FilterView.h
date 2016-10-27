//
//  FilterView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterView : UIView <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) void(^FilterCallBack)(NSArray *array,NSString *string);
@property (nonatomic) void(^DismissPickerViewCallBack) (id obj);

@property (nonatomic) UITableView *filterTableView;
@property (nonatomic) NSArray *orderStates;//订单状态
@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *details;
//查询
@property (nonatomic) UIButton *findBtn;
//重置
@property (nonatomic) UIButton *resetBtn;

@property (nonatomic) UIView *pickView;
@property (nonatomic) UIDatePicker *beginDatePicker;

@property (nonatomic) UIButton *closeImagePickerButton;//确定
@property (nonatomic) UIButton *cancelButton;

@property (nonatomic) UIPickerView *pickerView;//订单状态等pickerView

@end
