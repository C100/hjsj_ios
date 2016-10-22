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

@property (nonatomic) NSArray *phoneTopType;
@property (nonatomic) UITableViewCell *currentCell;

@property (nonatomic) UIDatePicker *beginDatePicker;
@property (nonatomic) UIButton *closeImagePickerButton;
@property (nonatomic) NSDate *beginDate;
@property (nonatomic) NSDate *endDate;
@property (nonatomic) NSString *thirdCondition;//第三个筛选条件
@property (nonatomic) NSString *forthCondition;//第四个筛选条件

@end

@implementation FilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.orderStates = [NSArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.phoneTopType = @[@"全部",@"余额充值",@"话费充值"];
        self.titles = @[@"起始时间",@"截止时间",@"订单状态",@"手机号码"];
        self.details = @[@"请选择",@"请选择",@"请选择",@"请输入手机号码"];
        [self filterTableView];
        [self findBtn];
        [self resetBtn];
        [self beginDatePicker];
    }
    return self;
}

- (UIDatePicker *)beginDatePicker{
    if (_beginDatePicker == nil) {
        _beginDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 64+80+240, screenWidth, screenHeight - 108 - 80 - 240)];
        [[UIApplication sharedApplication].keyWindow addSubview:_beginDatePicker];
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
        [closeButton setTitleColor:[Utils colorRGB:@"#333333"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeDatePickerAction) forControlEvents:UIControlEventTouchUpInside];
        closeButton.hidden = YES;
        self.closeImagePickerButton = closeButton;
    }
    return _beginDatePicker;
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
    if (indexPath.row == 3) {
        if ([self.details[indexPath.row] isEqualToString:@"请选择"]) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
        }else{
            cell.detailTextLabel.textColor = [Utils colorRGB:@"#cccccc"];
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
    }
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
            self.closeImagePickerButton.hidden = NO;
            [_beginDatePicker setMaximumDate:[NSDate date]];
            [_beginDatePicker setMinimumDate:nil];
            if (self.endDate) {
                [self.beginDatePicker setMaximumDate:self.endDate];
            }
        }
            break;
        case 1:
        {
            self.beginDatePicker.hidden = NO;
            self.closeImagePickerButton.hidden = NO;
            self.beginDatePicker.minimumDate = [NSDate date];
            [self.beginDatePicker setMaximumDate:nil];
            if (self.beginDate) {
                [self.beginDatePicker setMinimumDate:self.beginDate];
            }
        }
            break;
        case 2:
        {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"订单状态" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            for (int i = 0; i < self.orderStates.count; i ++) {
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.orderStates[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.currentCell.detailTextLabel.text = self.orderStates[i];
                }];
                [ac addAction:action1];
                self.thirdCondition = self.orderStates[i];
            }
            UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                self.currentCell.detailTextLabel.text = @"请选择";
            }];
            [ac addAction:action4];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
        }
            break;
        case 3:
        {
            if ([self.details[indexPath.row] isEqualToString:@"请选择"]) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"充值类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                for (int i = 0; i < self.phoneTopType.count; i ++) {
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.phoneTopType[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        self.currentCell.detailTextLabel.text = self.phoneTopType[i];
                        self.forthCondition = self.phoneTopType[i];
                    }];
                    [ac addAction:action1];
                }
                UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    self.currentCell.detailTextLabel.text = @"请选择";
                }];
                [ac addAction:action4];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
            }else{
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"请输入手机号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    
                }];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if ([Utils isMobile:ac.textFields.firstObject.text]) {
                        self.currentCell.detailTextLabel.text = ac.textFields.firstObject.text;
                        self.currentCell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
                        self.forthCondition = ac.textFields.firstObject.text;
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
        }
            break;
    }
}

#pragma mark - Method
//查询 70   重置 71
- (void)buttonClickedAction:(UIButton *)button{
    switch (button.tag) {
        case 70:
        {
            NSString *beginStr = @"无";
            NSString *endStr = @"无";
            if (self.beginDate) {
                beginStr = [[NSString stringWithFormat:@"%@",self.beginDate] componentsSeparatedByString:@" "].firstObject;
            }
            if (self.endDate) {
                endStr = [[NSString stringWithFormat:@"%@",self.endDate] componentsSeparatedByString:@" "].firstObject;
            }
            if (!self.thirdCondition) {
                self.thirdCondition = @"无";
            }
            if (!self.forthCondition) {
                self.forthCondition = @"无";
            }
            _FilterCallBack(beginStr,endStr,self.thirdCondition,self.forthCondition);
            NSLog(@"万事俱备，就要查询啦！！！！！！！！");
        }
            break;
        case 71:
        {
            self.beginDate = nil;
            self.endDate = nil;
            [self.filterTableView reloadData];
        }
            break;
    }
}

- (void)closeDatePickerAction{
    if ([self.currentCell.textLabel.text isEqualToString:@"起始时间"]) {
        self.beginDate = self.beginDatePicker.date;
    }
    if ([self.currentCell.textLabel.text isEqualToString:@"截止时间"]) {
        self.endDate = self.beginDatePicker.date;
    }
    NSString *dateString = [[NSString stringWithFormat:@"%@",self.beginDatePicker.date] componentsSeparatedByString:@" "].firstObject;
    self.currentCell.detailTextLabel.text = [NSString stringWithFormat:@"%@",dateString];
    self.beginDatePicker.hidden = YES;
    self.closeImagePickerButton.hidden = YES;
}

@end
