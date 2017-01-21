//
//  WhiteCardFilterView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/24.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "WhiteCardFilterView.h"
#import "NormalTableViewCell.h"

#define leftDistance (screenWidth - 210)/2.0

@interface WhiteCardFilterView ()

@property (nonatomic) NSArray *titles;
@property (nonatomic) UIButton *findBtn;
@property (nonatomic) UIButton *resetBtn;
@property (nonatomic) NormalTableViewCell *currentCell;
@property (nonatomic) int currentPickerType;

@end

@implementation WhiteCardFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = @[@"号码池",@"靓号规则"];
        self.currentPickerType = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self filterTableView];
        [self findBtn];
        [self resetBtn];
        [self pickView];
        [self pickerView];
        
    }
    return self;
}

- (UITableView *)filterTableView{
    if (_filterTableView == nil) {
        _filterTableView = [[UITableView alloc] init];
        [self addSubview:_filterTableView];
        [_filterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(80);
            make.width.mas_equalTo(screenWidth);
        }];
        _filterTableView.bounces = NO;
        _filterTableView.delegate = self;
        _filterTableView.dataSource = self;
        [_filterTableView registerClass:[NormalTableViewCell class] forCellReuseIdentifier:@"cell"];
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
        _findBtn.titleLabel.font = [UIFont systemFontOfSize:textfont12];
        _findBtn.tag = 10;
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
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:textfont12];
        _resetBtn.tag = 20;
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

- (UIView *)pickView{
    if (_pickerView == nil) {
        _pickView = [[UIView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:_pickView];
        [_pickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        _pickView.backgroundColor = [UIColor blackColor];
        _pickView.alpha = 0.6;
        _pickView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)];
        [_pickView addGestureRecognizer:tap];
    }
    return _pickView;
}

- (UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(screenHeight - 264);
        }];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.hidden = YES;
        
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 60, 270, 60, 30)];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:textfont14];
        [[UIApplication sharedApplication].keyWindow addSubview:sureButton];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[Utils colorRGB:@"#008bd5"] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(surePickerAction:) forControlEvents:UIControlEventTouchUpInside];
        sureButton.hidden = YES;
        self.sureButton = sureButton;
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 270, 60, 30)];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:textfont14];
        [[UIApplication sharedApplication].keyWindow addSubview:cancelButton];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[Utils colorRGB:@"#008bd5"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelPickerAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.hidden = YES;
        self.cancelButton = cancelButton;
    }
    return _pickerView;
}

#pragma mark - UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.currentPickerType == 0) {
        //号码池
        return self.numberPoolArray.count;
    }else{
        //靓号规则
        return self.numberTypeArray.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.currentPickerType == 0) {
        //号码池
        NSDictionary *dic = self.numberPoolArray[row];
        return dic[@"name"];
    }else{
        //靓号规则
        return self.numberTypeArray[row];
    }
    return @"无";
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    
    if (indexPath.row == self.titles.count - 1) {
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentPickerType = (int)indexPath.row;
    self.pickerView.hidden = NO;
    self.pickView.hidden = NO;
    self.sureButton.hidden = NO;
    self.cancelButton.hidden = NO;
    self.pickerView.alpha = 0;
    self.pickView.alpha = 0;
    self.sureButton.alpha = 0;
    self.cancelButton.alpha = 0;
    
    [UIView animateWithDuration:0.6 animations:^{
        self.pickerView.alpha = 1;
        self.pickView.alpha = 0.5;
        self.sureButton.alpha = 1;
        self.cancelButton.alpha = 1;
        
        
    } completion:^(BOOL finished) {
        
    }];
    [self.pickerView reloadAllComponents];
    self.currentCell = [tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Method
- (void)buttonClickedAction:(UIButton *)button{
    NSMutableArray *conditions = [NSMutableArray array];
    NSString *string = @"查询";
    switch (button.tag) {
        case 10://查询
        {
            for (int i = 0; i < 2; i ++) {
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
                NormalTableViewCell *cell = [self.filterTableView cellForRowAtIndexPath:indexP];
                if ([cell.detailLabel.text isEqualToString:@"请选择"]) {
                    [conditions addObject:@"无"];
                }else{
                    [conditions addObject:cell.detailLabel.text];
                }
            }
        }
            break;
        case 20://重置
        {
            string = @"重置";
            for (int i = 0; i < 2; i ++) {
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
                NormalTableViewCell *cell = [self.filterTableView cellForRowAtIndexPath:indexP];
                cell.detailLabel.text = @"请选择";
                [conditions addObject:@"无"];
            }
        }
            break;
    }
    
    _WhiteCardFilterCallBack(conditions,string);

}

- (void)surePickerAction:(UIButton *)button{
//    NSLog(@"确定");
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    if (self.currentPickerType == 0) {
        NSDictionary *dic = self.numberPoolArray[row];
        self.currentCell.detailLabel.text = dic[@"name"];
        self.currentPoolId = [NSString stringWithFormat:@"%@",dic[@"id"]];
    }else{
        self.currentCell.detailLabel.text = self.numberTypeArray[row];
        self.currentType = self.numberTypeArray[row];
    }
    [UIView animateWithDuration:0.6 animations:^{
        self.pickerView.alpha = 0;
        self.pickView.alpha = 0;
        self.sureButton.alpha = 0;
        self.cancelButton.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.pickerView.hidden = YES;
        self.pickView.hidden = YES;
        self.sureButton.hidden = YES;
        self.cancelButton.hidden = YES;

    }];
}

- (void)cancelPickerAction:(UIButton *)button{
//    NSLog(@"取消");
    [UIView animateWithDuration:0.6 animations:^{
        self.pickerView.alpha = 0;
        self.pickView.alpha = 0;
        self.sureButton.alpha = 0;
        self.cancelButton.alpha = 0;

    } completion:^(BOOL finished) {
        self.pickerView.hidden = YES;
        self.pickView.hidden = YES;
        self.sureButton.hidden = YES;
        self.cancelButton.hidden = YES;

    }];
}

- (void)dismissAction:(UITapGestureRecognizer *)tap{
    
    [UIView animateWithDuration:0.6 animations:^{
        self.pickerView.alpha = 0;
        self.pickView.alpha = 0;
        self.sureButton.alpha = 0;
        self.cancelButton.alpha = 0;

    } completion:^(BOOL finished) {
        self.pickerView.hidden = YES;
        self.pickView.hidden = YES;
        self.sureButton.hidden = YES;
        self.cancelButton.hidden = YES;        
    }];
}

@end
