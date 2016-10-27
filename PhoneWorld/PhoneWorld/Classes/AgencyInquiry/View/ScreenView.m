//
//  ScreenView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ScreenView.h"
#import "InputView.h"

#define leftDistance (screenWidth - 210)/2.0

@interface ScreenView ()

@property (nonatomic) NSDictionary *contentDic;
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSArray *rightDetails;
@property (nonatomic) UITableView *screenTableView;
@property (nonatomic) InputView *phoneInputView;//手机号码

@property (nonatomic) NSArray *currentPickerArray;

@property (nonatomic) UITableViewCell *currentCell;

@end

@implementation ScreenView

- (instancetype)initWithFrame:(CGRect)frame andContent:(NSDictionary *)content andLeftTitles:(NSArray *)titles andRightDetails:(NSArray *)details
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.leftTitles = titles;
        self.rightDetails = details;
        self.contentDic = content;
        [self screenTableView];
        
        NSArray *buttonTitleArr = @[@"查询",@"重置"];
        for (int i = 0; i < 2; i ++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(leftDistance + 110*i, self.contentDic.count*40+20, 100, 30)];
            button.backgroundColor = MainColor;
            button.layer.cornerRadius = 15;
            button.layer.masksToBounds = YES;
            [button setTitle:buttonTitleArr[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [self addSubview:button];
            [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self backPickView];
        [self pickerView];
        [self datePickerView];
        [self sureButton];
        [self cancelButton];
    }
    return self;
}

- (UITableView *)screenTableView{
    if (_screenTableView == nil) {
        _screenTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, self.contentDic.count*40) style:UITableViewStylePlain];
        _screenTableView.delegate = self;
        _screenTableView.dataSource = self;
        _screenTableView.bounces = NO;
        [_screenTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:_screenTableView];
    }
    return _screenTableView;
}

- (UIView *)backPickView{
    if (_backPickView == nil) {
        _backPickView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        [[UIApplication sharedApplication].keyWindow addSubview:_backPickView];
        _backPickView.backgroundColor = [UIColor blackColor];
        _backPickView.alpha = 0.5;
        _backPickView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackPickViewAction:)];
        [_backPickView addGestureRecognizer:tap];
    }
    return _backPickView;
}

- (UIPickerView *)pickerView{
    if (_pickerView == nil) {
        CGFloat height = screenHeight - 64 - self.contentDic.count * 40 -70 - 80;
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, screenHeight - height, screenWidth, height)];
        [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.hidden = YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIDatePicker *)datePickerView{
    if (_datePickerView == nil) {
        CGFloat height = screenHeight - 64 - self.contentDic.count * 40 -70 - 80;
        _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, screenHeight - height, screenWidth, height)];
        [[UIApplication sharedApplication].keyWindow addSubview:_datePickerView];
        [_datePickerView setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        _datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
        // 设置时区
        [_datePickerView setTimeZone:[NSTimeZone localTimeZone]];
        // 设置当前显示时间
        [_datePickerView setDate:[NSDate date] animated:YES];
        // 设置UIDatePicker的显示模式
        [_datePickerView setDatePickerMode:UIDatePickerModeDate];
        _datePickerView.hidden = YES;
    }
    return _datePickerView;
}

- (UIButton *)sureButton{
    if (_sureButton == nil) {
        CGFloat height = screenHeight - 64 - self.contentDic.count * 40 -70 - 80;
        _sureButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 60, screenHeight - height, 60, 30)];
        [[UIApplication sharedApplication].keyWindow addSubview:_sureButton];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[Utils colorRGB:@"#008bd5"] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(choosePickerAction:) forControlEvents:UIControlEventTouchUpInside];
        _sureButton.hidden = YES;
    }
    return _sureButton;
}

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        CGFloat height = screenHeight - 64 - self.contentDic.count * 40 -70 - 80;
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, screenHeight - height, 60, 30)];
        [[UIApplication sharedApplication].keyWindow addSubview:_cancelButton];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[Utils colorRGB:@"#008bd5"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(closePickerAction:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.hidden = YES;
    }
    return _cancelButton;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.leftTitles[indexPath.row];
    NSString *detail = self.rightDetails[indexPath.row];
    if ([title containsString:@"手机"]) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        self.phoneInputView = [[InputView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        self.phoneInputView.leftLabel.text = title;
        self.phoneInputView.textField.placeholder = detail;
        if (indexPath.row == self.contentDic.count - 1) {
            cell.separatorInset = UIEdgeInsetsZero;
            cell.layoutMargins = UIEdgeInsetsZero;
            cell.preservesSuperviewLayoutMargins = NO;
        }
        [cell.contentView addSubview:self.phoneInputView];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = title;
        cell.detailTextLabel.text = detail;
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [Utils colorRGB:@"#666666"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == self.contentDic.count - 1) {
            cell.separatorInset = UIEdgeInsetsZero;
            cell.layoutMargins = UIEdgeInsetsZero;
            cell.preservesSuperviewLayoutMargins = NO;
        }
        [cell layoutSubviews];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentCell = [self.screenTableView cellForRowAtIndexPath:indexPath];
    NSString *title = self.leftTitles[indexPath.row];
    if([self.contentDic[title] isKindOfClass:[NSArray class]]){
        NSLog(@"是数组啊");
        self.currentPickerArray = self.contentDic[title];
        [self.pickerView reloadAllComponents];
        self.backPickView.hidden = NO;
        self.pickerView.hidden = NO;
        self.sureButton.hidden = NO;
        self.cancelButton.hidden = NO;
    }else{
        if ([self.contentDic[title] isEqualToString:@"timePicker"]) {
            NSLog(@"选时间了");
            self.backPickView.hidden = NO;
            self.datePickerView.hidden = NO;
            self.sureButton.hidden = NO;
            self.cancelButton.hidden = NO;
        }
        if ([self.contentDic[title] isEqualToString:@"phoneNumber"]) {
            NSLog(@"手机号码");
        }
    }

}

#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.currentPickerArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSAttributedString *astring = [[NSAttributedString alloc] initWithString:self.currentPickerArray[row] attributes:@{NSForegroundColorAttributeName:[Utils colorRGB:@"#666666"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
//    return astring;
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *myView = nil;
    
    if (component == 0) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = self.currentPickerArray[row];
        myView.font = [UIFont systemFontOfSize:16];         //用label来设置字体大小
        myView.backgroundColor = [UIColor clearColor];
        myView.textColor = [Utils colorRGB:@"#666666"];
    }
    
    return myView;
}

#pragma mark - Method
- (void)buttonClickedAction:(UIButton *)button{
    NSMutableDictionary *conditions = [NSMutableDictionary dictionary];
    if ([button.currentTitle isEqualToString:@"查询"]) {
        for (int i = 0; i<self.leftTitles.count ;i ++) {
            NSString *title = self.leftTitles[i];
            if ([title isEqualToString:@"手机号码"]) {
                [conditions setObject:self.phoneInputView.textField.text forKey:@"手机号码"];
            }else{
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
                UITableViewCell *cell = [self.screenTableView cellForRowAtIndexPath:indexP];
                [conditions setObject:cell.detailTextLabel.text forKey:title];
            }
        }
    }else{
        [self.screenTableView reloadData];
        for (NSString *title in self.leftTitles) {
            [conditions setObject:@"" forKey:title];
        }
    }
    _ScreenCallBack(conditions,button.currentTitle);
}

- (void)choosePickerAction:(UIButton *)button{
    if ([self.currentCell.textLabel.text isEqualToString:@"起始时间"] || [self.currentCell.textLabel.text isEqualToString:@"截止时间"]) {
        NSString *dateString = [[NSString stringWithFormat:@"%@",self.datePickerView.date] componentsSeparatedByString:@" "].firstObject;
        self.currentCell.detailTextLabel.text = dateString;
    }else{
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        NSArray *array = self.contentDic[self.currentCell.textLabel.text];
        self.currentCell.detailTextLabel.text = array[row];
    }
    self.backPickView.hidden = YES;
    self.datePickerView.hidden = YES;
    self.pickerView.hidden = YES;
    self.sureButton.hidden = YES;
    self.cancelButton.hidden = YES;
}

- (void)closePickerAction:(UIButton *)button{
    self.backPickView.hidden = YES;
    self.datePickerView.hidden = YES;
    self.pickerView.hidden = YES;
    self.sureButton.hidden = YES;
    self.cancelButton.hidden = YES;
}

- (void)tapBackPickViewAction:(UITapGestureRecognizer *)tap{
    _ScreenDismissCallBack(tap);
}

@end
