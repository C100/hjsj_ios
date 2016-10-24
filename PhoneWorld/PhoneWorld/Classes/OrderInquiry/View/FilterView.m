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

//@property (nonatomic) NSArray *phoneTopType;
@property (nonatomic) UITableViewCell *currentCell;

//@property (nonatomic) NSDate *beginDate;
//@property (nonatomic) NSDate *endDate;

@end

@implementation FilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.orderStates = [NSArray array];
        self.backgroundColor = [UIColor whiteColor];
//        self.phoneTopType = @[@"全部",@"余额充值",@"话费充值"];
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

- (UIView *)pickView{
    if (_pickView == nil) {
        _pickView = [[UIView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:_pickView];
        [_pickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        _pickView.backgroundColor = [UIColor clearColor];
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

- (UITableView *)filterTableView{
    if (_filterTableView == nil) {
        _filterTableView = [[UITableView alloc] init];
        [self addSubview:_filterTableView];
        [_filterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(164);
        }];
        _filterTableView.delegate = self;
        _filterTableView.dataSource = self;
        _filterTableView.bounces = NO;
    }
    return _filterTableView;
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
    cell.detailTextLabel.text = self.details[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [Utils colorRGB:@"#666666"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentCell = [tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            self.beginDatePicker.hidden = NO;
            self.pickView.hidden = NO;
            self.closeImagePickerButton.hidden = NO;
            self.cancelButton.hidden = NO;
        }
            break;
        case 1:
        {
            self.beginDatePicker.hidden = NO;
            self.pickView.hidden = NO;
            self.closeImagePickerButton.hidden = NO;
            self.cancelButton.hidden = NO;
        }
            break;
        case 2:
        {
            [self.pickerView reloadAllComponents];
            self.pickView.hidden = NO;
            self.closeImagePickerButton.hidden = NO;
            self.cancelButton.hidden = NO;
            self.pickerView.hidden = NO;
        }
            break;
        case 3:
        {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"请输入手机号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([Utils isMobile:ac.textFields.firstObject.text]) {
                    self.currentCell.detailTextLabel.text = ac.textFields.firstObject.text;
                    self.currentCell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
                }else{
                    [Utils toastview:@"手机号格式不正确，请重新输入"];
                }
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [ac addAction:action1];
            [ac addAction:action2];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
        }
            break;
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.orderStates[row];
}

#pragma mark - Method
//查询 70   重置 71
- (void)buttonClickedAction:(UIButton *)button{
    switch (button.tag) {
        case 70:
        {
            NSMutableArray *conditions = [NSMutableArray array];
            for (int i = 0; i < 4; i ++) {
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
                UITableViewCell *cell = [self.filterTableView cellForRowAtIndexPath:indexP];
                if ([cell.detailTextLabel.text isEqualToString:@"请选择"]) {
                    [conditions addObject:@"无"];
                }else{
                    [conditions addObject:cell.detailTextLabel.text];
                }
            }

            _FilterCallBack(conditions);
            NSLog(@"万事俱备，就要查询啦！！！！！！！！");
            self.pickView.hidden = YES;
            self.beginDatePicker.hidden = YES;
            self.closeImagePickerButton.hidden = YES;
            self.cancelButton.hidden = YES;
        }
            break;
        case 71:
        {
            [self.filterTableView reloadData];
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
    self.beginDatePicker.hidden = YES;
    self.pickView.hidden = YES;
    self.closeImagePickerButton.hidden = YES;
    self.cancelButton.hidden = YES;
    self.pickerView.hidden = YES;
}

- (void)tapPickViewAction:(UITapGestureRecognizer *)tap{
    [Utils toastview:@"请确认..."];
}

@end
