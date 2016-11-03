//
//  FilterView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "FilterView.h"

#define leftDistance (screenWidth - 210)/2.0

@interface FilterView ()

@property (nonatomic) UITableViewCell *currentCell;

@end

@implementation FilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.orderStates = [NSArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.titles = @[@"起始时间",@"截止时间",@"订单状态",@"手机号码"];
        self.details = @[@"请选择",@"请选择",@"请选择",@"请输入手机号码"];
        [self filterTableView];
        [self findBtn];
        [self resetBtn];
        [self pickView];
        [self pickerView];
        [self beginDatePicker];
    }
    return self;
}

- (UITableView *)filterTableView{
    if (_filterTableView == nil) {
        _filterTableView = [[UITableView alloc] init];
        [self addSubview:_filterTableView];
        [_filterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(41*self.titles.count);
        }];
        _filterTableView.delegate = self;
        _filterTableView.dataSource = self;
        _filterTableView.bounces = NO;
        _filterTableView.tableFooterView = [UIView new];
    }
    return _filterTableView;
}

- (UIView *)pickView{
    if (_pickView == nil) {
        _pickView = [[UIView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:_pickView];
        [_pickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        _pickView.backgroundColor = [UIColor blackColor];
        _pickView.alpha = 0.5;
        _pickView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPickViewAction:)];
        [_pickView addGestureRecognizer:tap];
    }
    return _pickView;
}

- (UIDatePicker *)beginDatePicker{
    if (_beginDatePicker == nil) {
        _beginDatePicker = [[UIDatePicker alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:_beginDatePicker];
        [_beginDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(screenHeight - 64 - 80 - 240);
        }];
        [_beginDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        _beginDatePicker.backgroundColor = [UIColor whiteColor];
        _beginDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
        // 设置时区
        [_beginDatePicker setTimeZone:[NSTimeZone localTimeZone]];
        
        // 设置当前显示时间
        [_beginDatePicker setDate:[NSDate date] animated:YES];
        // 设置UIDatePicker的显示模式
        [_beginDatePicker setDatePickerMode:UIDatePickerModeDate];
        _beginDatePicker.hidden = YES;
        [_beginDatePicker setValue:[UIColor blackColor] forKey:@"textColor"];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 60, 64+80+240, 60, 30)];
        closeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [[UIApplication sharedApplication].keyWindow addSubview:closeButton];
        [closeButton setTitle:@"确定" forState:UIControlStateNormal];
        [closeButton setTitleColor:[Utils colorRGB:@"#008bd5"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeDatePickerAction:) forControlEvents:UIControlEventTouchUpInside];
        closeButton.hidden = YES;
        self.closeImagePickerButton = closeButton;
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64+80+240, 60, 30)];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [[UIApplication sharedApplication].keyWindow addSubview:cancelButton];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[Utils colorRGB:@"#008bd5"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(closeDatePickerAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.hidden = YES;
        self.cancelButton = cancelButton;
    }
    return _beginDatePicker;
}

- (UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(screenHeight - 64 - 80 - 240);
        }];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.hidden = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

/*----查询按钮--------*/
- (UIButton *)findBtn{
    if (_findBtn == nil) {
        _findBtn = [[UIButton alloc] init];
        _findBtn.backgroundColor = MainColor;
        _findBtn.layer.cornerRadius = 15;
        _findBtn.layer.masksToBounds = YES;
        
        [_findBtn setTitle:@"查询" forState:UIControlStateNormal];
        [_findBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _findBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _findBtn.tag = 70;
        [self addSubview:_findBtn];
        [_findBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftDistance);
            make.top.mas_equalTo(self.filterTableView.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        
        [_findBtn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findBtn;
}

/*----重置按钮--------*/
- (UIButton *)resetBtn{
    if (_resetBtn == nil) {
        _resetBtn = [[UIButton alloc] init];
        _resetBtn.backgroundColor = MainColor;
        _resetBtn.layer.cornerRadius = 15;
        _resetBtn.layer.masksToBounds = YES;
        
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _resetBtn.tag = 71;
        [self addSubview:_resetBtn];
        [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-leftDistance);
            make.top.mas_equalTo(self.filterTableView.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        [_resetBtn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if ([self.titles[indexPath.row] isEqualToString:@"手机号码"]) {
        self.phoneInputView = [[InputView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        self.phoneInputView.textField.placeholder = @"请输入手机号码";
        self.phoneInputView.leftLabel.text = @"手机号码";
        [cell.contentView addSubview:self.phoneInputView];
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        return cell;
    }
    cell.textLabel.text = self.titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
    cell.detailTextLabel.text = self.details[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [Utils colorRGB:@"#666666"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0 || indexPath.row == 1) {//起始时间或截止时间
        self.beginDatePicker.hidden = NO;
        self.pickView.hidden = NO;
        self.closeImagePickerButton.hidden = NO;
        self.cancelButton.hidden = NO;
        self.beginDatePicker.alpha = 0;
        self.pickView.alpha = 0;
        self.closeImagePickerButton.alpha = 0;
        self.cancelButton.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.beginDatePicker.alpha = 1;
            self.pickView.alpha = 0.5;
            self.closeImagePickerButton.alpha = 1;
            self.cancelButton.alpha = 1;
        } completion:^(BOOL finished) {
        }];

        [self endEditing:YES];
    }
    
    if (indexPath.row == 2) {
        [self.pickerView reloadAllComponents];
        
        self.pickerView.hidden = NO;
        self.pickView.hidden = NO;
        self.closeImagePickerButton.hidden = NO;
        self.cancelButton.hidden = NO;
        self.pickerView.alpha = 0;
        self.pickView.alpha = 0;
        self.closeImagePickerButton.alpha = 0;
        self.cancelButton.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.pickerView.alpha = 1;
            self.pickView.alpha = 0.5;
            self.closeImagePickerButton.alpha = 1;
            self.cancelButton.alpha = 1;
        } completion:^(BOOL finished) {
        }];
        [self endEditing:YES];
    }
}

#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.orderStates.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSAttributedString *astring = [[NSAttributedString alloc] initWithString:self.orderStates[row] attributes:@{NSForegroundColorAttributeName:[Utils colorRGB:@"#666666"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    return astring;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *myView = nil;
    
    if (component == 0) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = self.orderStates[row];
        myView.font = [UIFont systemFontOfSize:16];         //用label来设置字体大小
        myView.backgroundColor = [UIColor clearColor];
        myView.textColor = [Utils colorRGB:@"#666666"];
    }
    
    return myView;
}

#pragma mark - Method
//查询 70   重置 71
- (void)buttonClickedAction:(UIButton *)button{
    switch (button.tag) {
        case 70:
        {
            NSMutableArray *conditions = [NSMutableArray array];
            for (int i = 0; i < self.titles.count; i ++) {
                NSString *title = self.titles[i];
                if ([title isEqualToString:@"手机号码"]) {
                    if ([self.phoneInputView.textField.text isEqualToString:@""]) {
                        [conditions addObject:@"无"];
                    }else{
                        if ([Utils isMobile:self.phoneInputView.textField.text]) {
                            [conditions addObject:self.phoneInputView.textField.text];
                        }else{
                            [Utils toastview:@"请输入正确格式手机号"];
                            return;
                        }
                    }
                }else{
                    NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
                    UITableViewCell *cell = [self.filterTableView cellForRowAtIndexPath:indexP];
                    if ([cell.detailTextLabel.text isEqualToString:@"请选择"]) {
                        [conditions addObject:@"无"];
                    }else{
                        [conditions addObject:cell.detailTextLabel.text];
                    }
                }
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                self.beginDatePicker.alpha = 0;
                self.pickView.alpha = 0;
                self.closeImagePickerButton.alpha = 0;
                self.cancelButton.alpha = 0;
                self.pickerView.alpha = 0;
            } completion:^(BOOL finished) {
                self.beginDatePicker.hidden = YES;
                self.pickView.hidden = YES;
                self.closeImagePickerButton.hidden = YES;
                self.cancelButton.hidden = YES;
                self.pickerView.hidden = YES;
                _FilterCallBack(conditions,@"查询");
                NSLog(@"万事俱备，就要查询啦！！！！！！！！");
            }];
        }
            break;
        case 71:
        {
            [self.filterTableView reloadData];
            NSMutableArray *conditions = [NSMutableArray array];
            for (int i = 0; i < self.titles.count; i ++) {
                [conditions addObject:@"无"];
            }
            _FilterCallBack(conditions,@"重置");
        }
            break;
    }
}

- (void)closeDatePickerAction:(UIButton *)button{
    if ([button.currentTitle isEqualToString:@"确定"]) {
        NSString *dateString = [[NSString stringWithFormat:@"%@",self.beginDatePicker.date] componentsSeparatedByString:@" "].firstObject;
        self.currentCell.detailTextLabel.text = [NSString stringWithFormat:@"%@",dateString];
        if ([self.currentCell.textLabel.text containsString:@"订单"]) {
            NSInteger row = [self.pickerView selectedRowInComponent:0];
            self.currentCell.detailTextLabel.text = self.orderStates[row];
        }
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.beginDatePicker.alpha = 0;
        self.pickView.alpha = 0;
        self.closeImagePickerButton.alpha = 0;
        self.cancelButton.alpha = 0;
        self.pickerView.alpha = 0;
    } completion:^(BOOL finished) {
        self.beginDatePicker.hidden = YES;
        self.pickView.hidden = YES;
        self.closeImagePickerButton.hidden = YES;
        self.cancelButton.hidden = YES;
        self.pickerView.hidden = YES;
    }];
    
}

- (void)tapPickViewAction:(UITapGestureRecognizer *)tap{
    _DismissPickerViewCallBack(tap);
}

@end
