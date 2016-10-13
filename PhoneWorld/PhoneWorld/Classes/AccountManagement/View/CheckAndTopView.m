//
//  CheckAndTopView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CheckAndTopView.h"

#define imageWidth (screenWidth - 10*2 - 15)/2
#define hw 42/170.0  //图片宽高比

@implementation CheckAndTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self currentLeftMoney];
        [self topMoney];
        [self payType];
        [self moneyNum];
        [self aliPay];
        [self weixinPay];
        [self greenCheckIV1];
        [self greenCheckIV2];
        [self rechargeButton];
    }
    return self;
}

- (UILabel *)currentLeftMoney{
    if (_currentLeftMoney == nil) {
        _currentLeftMoney = [[UILabel alloc] init];
        [self addSubview:_currentLeftMoney];
        [_currentLeftMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
        }];
        _currentLeftMoney.textColor = [Utils colorRGB:@"#333333"];
        _currentLeftMoney.font = [UIFont systemFontOfSize:14];
        _currentLeftMoney.text = @"当前余额：";
    }
    return _currentLeftMoney;
}

- (UILabel *)topMoney{
    if (_topMoney == nil) {
        _topMoney = [[UILabel alloc] init];
        [self addSubview:_topMoney];
        [_topMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.currentLeftMoney.mas_bottom).mas_equalTo(30);
        }];
        _topMoney.textColor = [Utils colorRGB:@"#333333"];
        _topMoney.font = [UIFont systemFontOfSize:14];
        _topMoney.text = @"充值金额：";
    }
    return _topMoney;
}

- (UILabel *)payType{
    if (_payType == nil) {
        _payType = [[UILabel alloc] init];
        [self addSubview:_payType];
        [_payType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.topMoney.mas_bottom).mas_equalTo(30);
        }];
        _payType.textColor = [Utils colorRGB:@"#333333"];
        _payType.font = [UIFont systemFontOfSize:14];
        _payType.text = @"支付方式：";
    }
    return _payType;
}

- (UITextField *)moneyNum{
    if (_moneyNum == nil) {
        _moneyNum = [[UITextField alloc] init];
        [self addSubview:_moneyNum];
        [_moneyNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.currentLeftMoney.mas_bottom).mas_equalTo(24);
            make.right.mas_equalTo(-50);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(screenWidth - 50 - 80);
        }];
        _moneyNum.borderStyle = UITextBorderStyleRoundedRect;
        _moneyNum.placeholder = @"请输入金额";
        _moneyNum.textColor = [Utils colorRGB:@"#333333"];
        _moneyNum.font = [UIFont systemFontOfSize:14];
    }
    return _moneyNum;
}

- (UIButton *)aliPay{
    if (_aliPay == nil) {
        _aliPay = [[UIButton alloc] init];
        [self addSubview:_aliPay];
        [_aliPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.payType.mas_bottom).mas_equalTo(15);
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageWidth*hw);
        }];
        [_aliPay setImage:[UIImage imageNamed:@"apliy"] forState:UIControlStateNormal];
        _aliPay.tag = 501;
        [_aliPay addTarget:self action:@selector(payTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aliPay;
}

- (UIButton *)weixinPay{
    if (_weixinPay == nil) {
        _weixinPay = [[UIButton alloc] init];
        [self addSubview:_weixinPay];
        [_weixinPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.payType.mas_bottom).mas_equalTo(15);
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(imageWidth*hw);
        }];
        [_weixinPay setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        _weixinPay.tag = 502;
        [_weixinPay addTarget:self action:@selector(payTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinPay;
}

- (UIImageView *)greenCheckIV1{
    if (_greenCheckIV1 == nil) {
        _greenCheckIV1 = [[UIImageView alloc] init];
        [self addSubview:_greenCheckIV1];
        [_greenCheckIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.aliPay.mas_top).mas_equalTo(4);
            make.right.mas_equalTo(self.aliPay.mas_right).mas_equalTo(-4);
            make.width.height.mas_equalTo(25);
        }];
        _greenCheckIV1.image = [UIImage imageNamed:@"check_green"];
        _greenCheckIV1.hidden = YES;
    }
    return _greenCheckIV1;
}

- (UIImageView *)greenCheckIV2{
    if (_greenCheckIV2 == nil) {
        _greenCheckIV2 = [[UIImageView alloc] init];
        [self addSubview:_greenCheckIV2];
        [_greenCheckIV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.weixinPay.mas_top).mas_equalTo(4);
            make.right.mas_equalTo(self.weixinPay.mas_right).mas_equalTo(-4);
            make.width.height.mas_equalTo(25);
        }];
        _greenCheckIV2.image = [UIImage imageNamed:@"check_green"];
        _greenCheckIV2.hidden = YES;
    }
    return _greenCheckIV2;
}

- (UIButton *)rechargeButton{
    if (_rechargeButton == nil) {
        _rechargeButton = [[UIButton alloc] init];
        [self addSubview:_rechargeButton];
        [_rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.aliPay.mas_bottom).mas_equalTo(20);
            make.height.mas_equalTo(40);
        }];
        _rechargeButton.backgroundColor = [Utils colorRGB:@"#008bd5"];
        _rechargeButton.layer.cornerRadius = 6;
        _rechargeButton.layer.masksToBounds = YES;
        [_rechargeButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_rechargeButton setTintColor:[UIColor whiteColor]];
        _rechargeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rechargeButton.tag = 503;
        [_rechargeButton addTarget:self action:@selector(payTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeButton;
}

#pragma mark - Method
- (void)payTypeAction:(UIButton *)button{
    _checkAndTopCallBack(button.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
