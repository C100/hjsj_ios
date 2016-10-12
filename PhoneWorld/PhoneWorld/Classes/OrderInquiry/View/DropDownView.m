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

@implementation DropDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self timeLB];
        [self endTime];
        [self v];
        [self beginTime];
        
        [self stateLB];
        [self stateTF];
        
        [self phoneLB];
        [self phoneTF];
        
        [self findBtn];
        [self resetBtn];
    }
    return self;
}

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
        NSString *dateStr = [NSString stringWithFormat:@"%@",date];
        
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
        NSString *dateStr = [NSString stringWithFormat:@"%@",date];
        
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
            make.right.mas_equalTo(_stateTF.mas_right).mas_equalTo(-6);
            make.top.mas_equalTo(_stateTF.mas_top).mas_equalTo(12);
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(6);
        }];
        [btn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    }
    return _stateTF;
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
        _phoneTF.enabled = NO;
        
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
            make.right.mas_equalTo(_phoneTF.mas_right).mas_equalTo(-6);
            make.top.mas_equalTo(_phoneTF.mas_top).mas_equalTo(12);
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(6);
        }];
        [btn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    }
    return _phoneTF;
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
        
        [self addSubview:_findBtn];
        [_findBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_equalTo(80);
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(30);
        }];
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
        
        [self addSubview:_resetBtn];
        [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_equalTo(-80);
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(self.findBtn.mas_width);
            make.height.mas_equalTo(30);
        }];
    }
    return _resetBtn;
}

@end
