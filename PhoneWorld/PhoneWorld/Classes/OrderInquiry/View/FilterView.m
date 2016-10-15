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
//保存筛选条件
@property (nonatomic) NSString *beginTime;
@property (nonatomic) NSString *endTime;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *phoneNumber;

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
    }
    return self;
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

- (CJCalendarViewController *)calendarViewController{
    if (_calendarViewController == nil) {
        _calendarViewController = [[CJCalendarViewController alloc] init];
        _calendarViewController.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 64);
        _calendarViewController.delegate = self;
        _calendarViewController.headerBackgroundColor = MainColor;
        _calendarViewController.contentBackgroundColor = MainColor;
    }
    return _calendarViewController;
}

#pragma mark - CJCalendarViewController Delegate
-(void)CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    NSString *string = [NSString stringWithFormat:@"%02d-%02d-%02d", year.integerValue, month.integerValue, day.integerValue];
    self.currentCell.detailTextLabel.text = string;
    if ([self.currentCell.textLabel.text isEqualToString:@"起始时间"]) {
        self.beginTime = string;
    }else{
        self.endTime = string;
    }
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
            [self showCalendar];
        }
            break;
        case 1:
        {
            [self showCalendar];
        }
            break;
        case 2:
        {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"订单状态" message:nil preferredStyle:UIAlertControllerStyleAlert];
            for (int i = 0; i < self.orderStates.count; i ++) {
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.orderStates[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.currentCell.detailTextLabel.text = self.orderStates[i];
                }];
                [ac addAction:action1];
            }
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
        }
            break;
        case 3:
        {
            if ([self.details[indexPath.row] isEqualToString:@"请选择"]) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"充值类型" message:nil preferredStyle:UIAlertControllerStyleAlert];
                for (int i = 0; i < self.phoneTopType.count; i ++) {
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.phoneTopType[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        self.currentCell.detailTextLabel.text = self.phoneTopType[i];
                    }];
                    [ac addAction:action1];
                }
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
            }else{
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"请输入手机号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    
                }];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if ([Utils isMobile:ac.textFields.firstObject.text]) {
                        self.currentCell.detailTextLabel.text = ac.textFields.firstObject.text;
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
- (void)showCalendar{
    NSDate *date = [[NSDate alloc] init];
    NSString *dateStr = [[NSString stringWithFormat:@"%@",date] componentsSeparatedByString:@" "].firstObject;
    NSArray *arr = [dateStr componentsSeparatedByString:@"-"];
    if (arr.count > 1) {
        [self.calendarViewController setYear:arr[0] month:arr[1] day:arr[2]];
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.calendarViewController animated:YES completion:nil];
}

//查询 70   重置 71
- (void)buttonClickedAction:(UIButton *)button{
    switch (button.tag) {
        case 70:
        {
            if (self.beginTime == nil) {
                [Utils toastview:@"请选择起始时间"];
            }else if(self.endTime == nil){
                [Utils toastview:@"请选择截止时间"];
            }else{
                NSString *beginStr = [self.beginTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
                NSString *endStr = [self.endTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
                NSInteger beginInt = beginStr.integerValue;
                NSInteger endInt = endStr.integerValue;
                if (beginInt > endInt) {
                    [Utils toastview:@"起始时间不得晚于截止时间"];
                }else{
                    NSLog(@"万事俱备，就要查询啦！！！！！！！！");
                }
            }
        }
            break;
        case 71:
        {
            [self.filterTableView reloadData];
        }
            break;
    }
}

@end
