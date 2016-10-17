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

@interface CheckAndTopView ()

@property (nonatomic) NSArray *imageNames;

@end

@implementation CheckAndTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.imageNames = @[@"weixin1",@"alipay1"];
        self.buttons = [NSMutableArray array];
        [self currentLeftMoney];
        [self currentRightMoney];
        [self topMoney];
        [self payWay];
        [self nextButton];
    }
    return self;
}

- (UILabel *)currentLeftMoney{
    if (_currentLeftMoney == nil) {
        _currentLeftMoney = [[UILabel alloc] init];
        _currentLeftMoney.backgroundColor = [UIColor whiteColor];
        [self addSubview:_currentLeftMoney];
        [_currentLeftMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _currentLeftMoney.textColor = [Utils colorRGB:@"#666666"];
        _currentLeftMoney.font = [UIFont systemFontOfSize:14];
        _currentLeftMoney.text = @"    当前余额";
    }
    return _currentLeftMoney;
}

- (UILabel *)currentRightMoney{
    if (_currentRightMoney == nil) {
        _currentRightMoney = [[UILabel alloc] init];
        _currentRightMoney.backgroundColor = [UIColor whiteColor];
        _currentRightMoney.textAlignment = NSTextAlignmentRight;
        [self addSubview:_currentRightMoney];
        [_currentRightMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(40);
        }];
        _currentRightMoney.textColor = [Utils colorRGB:@"#666666"];
        _currentRightMoney.font = [UIFont systemFontOfSize:12];
        _currentRightMoney.text = @"99";
    }
    return _currentRightMoney;
}

- (UIView *)topMoney{
    if (_topMoney == nil) {
        _topMoney = [[UIView alloc] init];
        [self addSubview:_topMoney];
        [_topMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.currentLeftMoney.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(40);
        }];
        _topMoney.backgroundColor = [UIColor whiteColor];
        
        UILabel *leftLB = [[UILabel alloc] init];
        [_topMoney addSubview:leftLB];
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        leftLB.text = @"充值金额";
        leftLB.textColor = [Utils colorRGB:@"#666666"];
        leftLB.font = [UIFont systemFontOfSize:14];
        
        UILabel *rightLB = [[UILabel alloc] init];
        [_topMoney addSubview:rightLB];
        [rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(leftLB.mas_right).mas_equalTo(0);
        }];
        rightLB.textAlignment = NSTextAlignmentRight;
        rightLB.text = @"请输入金额";
        rightLB.textColor = [Utils colorRGB:@"#cccccc"];
        rightLB.font = [UIFont systemFontOfSize:12];
        self.number = rightLB;
        
        UITextField *tf = [[UITextField alloc] init];
        [_topMoney addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(leftLB.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(30);
        }];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.hidden = YES;
        tf.textColor = [Utils colorRGB:@"#666666"];
        tf.font = [UIFont systemFontOfSize:14];
        [tf setReturnKeyType:UIReturnKeyDone];
        tf.delegate = self;
        self.moneyNumTF = tf;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_topMoney addGestureRecognizer:tap];
    }
    return _topMoney;
}

- (UIView *)payWay{
    if (_payWay == nil) {
        _payWay = [[UIView alloc] init];
        [self addSubview:_payWay];
        [_payWay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topMoney.mas_bottom).mas_equalTo(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(151);
        }];
        _payWay.backgroundColor = [UIColor whiteColor];
        
        UILabel *leftLB = [[UILabel alloc] init];
        [_payWay addSubview:leftLB];
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(16);
        }];
        leftLB.text = @"选择支付方式";
        leftLB.textColor = [Utils colorRGB:@"#666666"];
        leftLB.font = [UIFont systemFontOfSize:14];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePayWay:)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePayWay:)];

        for (int i = 0; i<2; i++) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 26 + 65*i, screenWidth, 64)];
            if (i == 0) {
                [v addGestureRecognizer:tap1];
            }else{
                [v addGestureRecognizer:tap2];
            }
            v.tag = 10+i;
            [_payWay addSubview:v];
            UIButton *pay = [[UIButton alloc] init];
            [v addSubview:pay];
            [pay mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(29);
                make.width.height.mas_equalTo(11);
            }];
            pay.backgroundColor = [Utils colorRGB:@"#eaeaea"];
            pay.layer.borderColor = [Utils colorRGB:@"#cccccc"].CGColor;
            pay.layer.borderWidth = 1;
            pay.layer.cornerRadius = 5;
            pay.layer.masksToBounds = YES;
            pay.tag = 100+i;
            [self.buttons addObject:pay];
            
            UIImageView *imageV = [[UIImageView alloc] init];
            [v addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(12);
                make.left.mas_equalTo(41);
                make.width.height.mas_equalTo(40);
            }];
            imageV.image = [UIImage imageNamed:self.imageNames[i]];
            
            UILabel *lb = [[UILabel alloc] init];
            [v addSubview:lb];
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0);
                make.left.mas_equalTo(imageV.mas_right).mas_equalTo(10);
            }];
//            if (<#condition#>) {
//                <#statements#>
//            }
        }
    }
    return _payWay;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.payWay.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.moneyNumTF.hidden = self.moneyNumTF.hidden == NO ? YES : NO;
    self.number.text = self.moneyNumTF.text;
    self.number.textColor = [Utils colorRGB:@"#666666"];
    [self endEditing:YES];
    return YES;
}

#pragma mark - Method
- (void)nextAction:(UIButton *)button{
    _checkAndTopCallBack(self.moneyNumTF.text, self.payway);
}

- (void)choosePayWay:(UITapGestureRecognizer *)tap{
    for (UIButton *button in self.buttons) {
        button.backgroundColor = [Utils colorRGB:@"#eaeaea"];
        button.layer.borderColor = [Utils colorRGB:@"#cccccc"].CGColor;
        button.layer.borderWidth = 1;
    }
    NSInteger t = tap.view.tag - 10 + 100;
    UIButton *btn = [self viewWithTag:t];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = [Utils colorRGB:@"#0081eb"].CGColor;
    btn.layer.borderWidth = 3;
    if (t == 100) {
        self.payway = weixinPay;
    }else{
        self.payway = aliPay;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    self.moneyNumTF.hidden = self.moneyNumTF.hidden == NO ? YES : NO;
    [self.moneyNumTF becomeFirstResponder];
}

@end
