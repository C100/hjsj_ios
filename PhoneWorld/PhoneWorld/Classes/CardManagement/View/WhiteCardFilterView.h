//
//  WhiteCardFilterView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/24.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhiteCardFilterView : UIView <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) void(^WhiteCardFilterCallBack)(NSArray *array);
@property (nonatomic) UITableView *filterTableView;
@property (nonatomic) UIView *pickView;
@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) UIButton *sureButton;
@property (nonatomic) UIButton *cancelButton;

@end