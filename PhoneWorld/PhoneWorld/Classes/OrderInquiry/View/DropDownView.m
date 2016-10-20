//
//  DropDownView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "DropDownView.h"

#define dateTFWidth (screenWidth - 90 - 80 - 14)/2
#define buttonWidth (screenWidth - 170)/2

@interface DropDownView ()

@property (nonatomic) UITextField *currentTF;
@property (nonatomic) NSArray *topStates;

@end

@implementation DropDownView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.states = [NSArray array];
//        self.topStates = @[@"全部",@"余额充值",@"话费充值"];
//        [self timeLB];
//        [self endTime];
//        [self v];
//        [self beginTime];
//        
//        [self stateLB];
//        [self stateTF];
//        
//        [self phoneLB];
//        [self phoneTF];
//        
//        [self findBtn];
//        [self resetBtn];
//        
//        [self stateTableView];
//    }
//    return self;
//}

/*---------时间-----------------*/
- (UILabel *)timeLB{
    if (_timeLB == nil) {
        _timeLB = [[UILabel alloc] init];
        [self addSubview:_timeLB];
        _timeLB.font = [UIFont systemFontOfSize:14];
        _timeLB.textColor = [Utils colorRGB:@"#333333"];
        _timeLB.text = @"订单时间：";
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_equalTo(45);
            make.top.mas_equalTo(self.mas_top).mas_equalTo(25);
            
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(80);
        }];
    }
    return _timeLB;
}

- (UITextField *)beginTime{
    if (_beginTime == nil) {
        _beginTime = [[UITextField alloc] init];
        _beginTime.borderStyle = UITextBorderStyleRoundedRect;
        _beginTime.layer.borderColor = kRGBA(204, 204, 204, 1).CGColor;
        _beginTime.layer.cornerRadius = 6;
        _beginTime.layer.borderWidth = 1;
        _beginTime.enabled = NO;
        [_beginTime setFont:[UIFont systemFontOfSize:12]];
        [_beginTime setTextColor:[Utils colorRGB:@"#666666"]];
        
        NSDate *date = [[NSDate alloc] init];
        NSString *dateStr = [[NSString stringWithFormat:@"%@",date] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        
        _beginTime.text = [dateStr componentsSeparatedByString:@" "].firstObject;
        
        _beginTime.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 13, 20)];
        _beginTime.rightViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:_beginTime];
        [_beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeLB.mas_right).mas_equalTo(0);
            make.top.mas_equalTo(self.mas_top).mas_equalTo(20);
            make.width.mas_equalTo(dateTFWidth);
            make.height.mas_equalTo(28);
        }];
        
        UIButton *btnBegin = [[UIButton alloc] init];
        [self addSubview:btnBegin];
        [btnBegin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_beginTime.mas_right).mas_equalTo(-6);
            make.top.mas_equalTo(_beginTime.mas_top).mas_equalTo(8);
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(13);
        }];
        [btnBegin setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
        btnBegin.tag = 150;;
        [btnBegin addTarget:self action:@selector(chooseCalendarAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beginTime;
}

- (UIView *)v{
    if (_v == nil) {
        _v = [[UIView alloc] init];
        [self addSubview:_v];
        _v.backgroundColor = kRGBA(204, 204, 204, 1);
        [_v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.endTime.mas_left).mas_equalTo(-4);
            make.top.mas_equalTo(33);
            make.width.mas_equalTo(6);
            make.height.mas_equalTo(1);
        }];
    }
    return _v;
}

- (UITextField *)endTime{
    if (_endTime == nil) {
        _endTime = [[UITextField alloc] init];
        _endTime.borderStyle = UITextBorderStyleRoundedRect;
        _endTime.layer.borderColor = kRGBA(204, 204, 204, 1).CGColor;
        _endTime.layer.cornerRadius = 6;
        _endTime.layer.borderWidth = 1;
        _endTime.enabled = NO;
        
        [_endTime setFont:[UIFont systemFontOfSize:12]];
        [_endTime setTextColor:[Utils colorRGB:@"#666666"]];
        
        NSDate *date = [[NSDate alloc] init];
        NSString *dateStr = [[NSString stringWithFormat:@"%@",date] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        
        _endTime.text = [dateStr componentsSeparatedByString:@" "].firstObject;
        
        _endTime.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 13, 20)];
        _endTime.rightViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:_endTime];
        [_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_equalTo(-45);
            make.top.mas_equalTo(self.mas_top).mas_equalTo(20);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(dateTFWidth);
        }];
        
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_endTime.mas_right).mas_equalTo(-6);
            make.top.mas_equalTo(_endTime.mas_top).mas_equalTo(8);
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(13);
        }];
        [btn setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
        btn.tag = 151;
        [btn addTarget:self action:@selector(chooseCalendarAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endTime;
}

/*---------状态-----------------*/
- (UILabel *)stateLB{
    if (_stateLB == nil) {
        _stateLB = [[UILabel alloc] init];
        [self addSubview:_stateLB];
        _stateLB.font = [UIFont systemFontOfSize:14];
        _stateLB.textColor = [Utils colorRGB:@"#333333"];
        _stateLB.text = @"订单状态：";
        [_stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timeLB.mas_bottom).mas_equalTo(34);
            make.left.mas_equalTo(self.mas_left).mas_equalTo(45);
            
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(80);
        }];
    }
    return _stateLB;
}

- (UITextField *)stateTF{
    if (_stateTF == nil) {
        _stateTF = [[UITextField alloc] init];
        _stateTF.borderStyle = UITextBorderStyleRoundedRect;
        _stateTF.layer.borderColor = kRGBA(204, 204, 204, 1).CGColor;
        _stateTF.layer.cornerRadius = 6;
        _stateTF.layer.borderWidth = 1;
        _stateTF.enabled = NO;
        
        [_stateTF setFont:[UIFont systemFontOfSize:12]];
        [_stateTF setTextColor:[Utils colorRGB:@"#666666"]];
        
        [self addSubview:_stateTF];
        [_stateTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_equalTo(-45);
            make.top.mas_equalTo(self.beginTime.mas_bottom).mas_equalTo(20);
            make.height.mas_equalTo(28);
            make.left.mas_equalTo(self.stateLB.mas_right).mas_equalTo(0);
        }];
        
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_stateTF.mas_right).mas_equalTo(0);
            make.top.mas_equalTo(_stateTF.mas_top).mas_equalTo(0);
            make.width.mas_equalTo(24);
            make.height.mas_equalTo(30);
        }];
        [btn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(12, 6, 12, 6)];
        btn.tag = 52;
        [btn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stateTF;
}

- (UITableView *)stateTableView{
    if (_stateTableView == nil) {
        _stateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        [self addSubview:_stateTableView];
        [_stateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.stateTF.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(self.phoneLB.mas_right).mas_equalTo(0);
            make.height.mas_equalTo(3*28);
            make.right.mas_equalTo(-50);
        }];
        _stateTableView.tag = 32;
        _stateTableView.delegate = self;
        _stateTableView.dataSource = self;
        _stateTableView.layer.cornerRadius = 6;
        _stateTableView.layer.masksToBounds = YES;
        _stateTableView.layer.borderColor = COLOR_BACKGROUND.CGColor;
        _stateTableView.layer.borderWidth = 1;
        _stateTableView.bounces = NO;
        _stateTableView.hidden = YES;
    }
    return _stateTableView;
}

/*---------手机号-----------------*/
- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        [self addSubview:_phoneLB];
        _phoneLB.font = [UIFont systemFontOfSize:14];
        _phoneLB.textColor = [Utils colorRGB:@"#333333"];
        _phoneLB.text = @"手机号码：";
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.stateLB.mas_bottom).mas_equalTo(34);
            make.left.mas_equalTo(self.mas_left).mas_equalTo(45);
            
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(80);
        }];
    }
    return _phoneLB;
}

- (UITextField *)phoneTF{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
        _phoneTF.layer.borderColor = kRGBA(204, 204, 204, 1).CGColor;
        _phoneTF.layer.cornerRadius = 6;
        _phoneTF.layer.borderWidth = 1;
        _phoneTF.placeholder = @"请输入手机号码";
        
        [_phoneTF setFont:[UIFont systemFontOfSize:12]];
        [_phoneTF setTextColor:[Utils colorRGB:@"#666666"]];
        
        [self addSubview:_phoneTF];
        [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_equalTo(-45);
            make.top.mas_equalTo(self.stateTF.mas_bottom).mas_equalTo(20);
            make.height.mas_equalTo(28);
            make.left.mas_equalTo(self.phoneLB.mas_right).mas_equalTo(0);
        }];
        
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_phoneTF.mas_right).mas_equalTo(0);
            make.top.mas_equalTo(_phoneTF.mas_top).mas_equalTo(0);
            make.width.mas_equalTo(24);
            make.height.mas_equalTo(30);
        }];
        [btn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(12, 6, 12, 6)];
        
        btn.tag = 55;
        [btn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        self.phoneShowBtn = btn;
    }
    return _phoneTF;
}

- (UITableView *)topStateTableView{
    if (_topStateTableView == nil) {
        _topStateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        [self addSubview:_topStateTableView];
        [_topStateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(self.phoneLB.mas_right).mas_equalTo(0);
            make.height.mas_equalTo(3*28);
            make.right.mas_equalTo(-50);
        }];
        _topStateTableView.tag = 31;
        _topStateTableView.delegate = self;
        _topStateTableView.dataSource = self;
        _topStateTableView.layer.cornerRadius = 6;
        _topStateTableView.layer.masksToBounds = YES;
        _topStateTableView.layer.borderColor = COLOR_BACKGROUND.CGColor;
        _topStateTableView.layer.borderWidth = 1;
        _topStateTableView.bounces = NO;
        _topStateTableView.hidden = YES;
    }
    return _topStateTableView;
}

/*----查询按钮--------*/
- (UIButton *)findBtn{
    if (_findBtn == nil) {
        _findBtn = [[UIButton alloc] init];
        _findBtn.backgroundColor = [Utils colorRGB:@"#008bd5"];
        _findBtn.layer.cornerRadius = 6;
        _findBtn.layer.masksToBounds = YES;
        
        [_findBtn setTitle:@"查询" forState:UIControlStateNormal];
        [_findBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _findBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _findBtn.tag = 50;
        [self addSubview:_findBtn];
        [_findBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_equalTo(80);
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(buttonWidth);
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
        _resetBtn.backgroundColor = [Utils colorRGB:@"#008BD5"];
        _resetBtn.layer.cornerRadius = 6;
        _resetBtn.layer.masksToBounds = YES;
        
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _resetBtn.tag = 51;
        [self addSubview:_resetBtn];
        [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_equalTo(-80);
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(self.findBtn.mas_width);
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
    
    self.currentTF.text = [NSString stringWithFormat:@"%@.%@.%@", year, month, day];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 31) {
        return self.topStates.count;
    }
    return self.states.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [Utils colorRGB:@"#333333"];
    cell.textLabel.text = self.states[indexPath.row];
    if (tableView.tag == 31) {
        cell.textLabel.text = self.topStates[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 32) {
        NSString *state = self.states[indexPath.row];
        self.stateTF.text = state;
        self.stateTableView.hidden = YES;
    }else if(tableView.tag == 31){
        self.phoneTF.text = self.topStates[indexPath.row];
        self.topStateTableView.hidden = YES;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 28;
}

#pragma mark - Method
//点击重置(51)和查询(50)按钮  选择状态（52）  充值类型（55）
- (void)buttonClickedAction:(UIButton *)button{
    if (button.tag == 52) {
        [UIView animateWithDuration:0.5 animations:^{
            self.stateTableView.hidden = self.stateTableView.hidden==YES ? NO : YES;
        }];
    }
    if (button.tag == 51) {
        NSDate *date = [[NSDate alloc] init];
        NSString *dateStr = [[NSString stringWithFormat:@"%@",date] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        self.beginTime.text = [dateStr componentsSeparatedByString:@" "].firstObject;
        self.endTime.text = [dateStr componentsSeparatedByString:@" "].firstObject;
        self.stateTF.text = @"";
        self.phoneTF.text = @"";
    }
    if (button.tag == 50) {
        //查询操作
        _DropDownCallBack(button.tag);
    }
    if (button.tag == 55) {
        //充值
        [UIView animateWithDuration:0.5 animations:^{
            self.topStateTableView.hidden = self.topStateTableView.hidden==YES ? NO : YES;
        }];
    }
}

//日历begin(150)  end(151)
- (void)chooseCalendarAction:(UIButton *)button{
    NSArray *arr = [NSArray array];
    if (button.tag == 150) {
        arr = [self.beginTime.text componentsSeparatedByString:@"."];
        self.currentTF = self.beginTime;
    }else if(button.tag == 151){
        self.currentTF = self.endTime;
        arr = [self.endTime.text componentsSeparatedByString:@"."];
    }
    
    if (arr.count > 1) {
        [self.calendarViewController setYear:arr[0] month:arr[1] day:arr[2]];
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.calendarViewController animated:YES completion:nil];
}

@end
