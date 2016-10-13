//
//  OrderView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneCashCheckView.h"

@implementation PhoneCashCheckView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self phoneLB];
        [self findButton];
        [self phoneTF];
        [self lineView];
        [self accountCash];
    }
    return self;
}

- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        _phoneLB.text = @"手机号码：";
        [self addSubview:_phoneLB];
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_equalTo(15);
            make.left.mas_equalTo(self.mas_left).mas_equalTo(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(17);
        }];
        _phoneLB.textColor = [Utils colorRGB:@"#333333"];
        _phoneLB.font = [UIFont systemFontOfSize:14];
    }
    return _phoneLB;
}

- (UIButton *)findButton{
    if (_findButton == nil) {
        _findButton = [[UIButton alloc] init];
        [self addSubview:_findButton];
        [_findButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(60);
        }];
        _findButton.backgroundColor = [Utils colorRGB:@"#008bd5"];
        _findButton.layer.cornerRadius = 6;
        _findButton.layer.masksToBounds = YES;
        [_findButton setTitle:@"查询" forState:UIControlStateNormal];
        [_findButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _findButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _findButton.tag = 400;
        [_findButton addTarget:self action:@selector(findAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findButton;
}

- (void)findAction:(UIButton *)button{
    _orderCallBack(button.tag);
}

- (UITextField *)phoneTF{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_phoneTF];
        [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_equalTo(10);
            make.left.mas_equalTo(self.phoneLB.mas_right).mas_equalTo(0);
            make.height.mas_equalTo(28);
            make.right.mas_equalTo(self.findButton.mas_left).mas_equalTo(-10);
        }];
    }
    return _phoneTF;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(1);
            make.left.right.mas_equalTo(0);
        }];
        _lineView.backgroundColor = [Utils colorRGB:@"#efefef"];
    }
    return _lineView;
}

- (UILabel *)accountCash{
    if (_accountCash == nil) {
        _accountCash = [[UILabel alloc] init];
        [self addSubview:_accountCash];
        [_accountCash mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.lineView.mas_bottom).mas_equalTo(10);
        }];
        _accountCash.textColor = [Utils colorRGB:@"#333333"];
        _accountCash.font = [UIFont systemFontOfSize:14];
        _accountCash.text = @"账户余额：";
    }
    return _accountCash;
}

@end
