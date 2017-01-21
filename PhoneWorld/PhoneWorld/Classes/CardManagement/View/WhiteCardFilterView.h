//
//  WhiteCardFilterView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/24.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WhiteCardFilterView : UIView <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) void(^WhiteCardFilterCallBack)(NSArray *array,NSString *string);

@property (nonatomic) UITableView *filterTableView;
@property (nonatomic) UIView *pickView;
@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) UIButton *sureButton;
@property (nonatomic) UIButton *cancelButton;

//白卡开户筛选条件
@property (nonatomic) NSArray *numberPoolArray;//号码池数组
@property (nonatomic) NSArray *numberTypeArray;//靓号规则

//筛选条件
@property (nonatomic) NSString *currentPoolId;//号码池ID
@property (nonatomic) NSString *currentType;//靓号规则

@end
