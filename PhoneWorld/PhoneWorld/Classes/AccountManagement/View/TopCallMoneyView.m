//
//  TopCallMoneyView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopCallMoneyView.h"

#define btnWidth (screenWidth - 46)/3.0
#define hw 70/113.0
#define btnTopDistance (btnWidth*hw - 16 - 4 - 13)/2.0

@interface TopCallMoneyView ()

@property (nonatomic) NSArray *titleArr;
@property (nonatomic) NSArray *detailArr;
@property (nonatomic) NSMutableArray *buttonArr;
@property (nonatomic) NSInteger money;
@property (nonatomic) UIView *grayView;

@end

@implementation TopCallMoneyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonArr = [NSMutableArray array];
        self.backgroundColor = COLOR_BACKGROUND;
        self.titleArr = @[@"10元",@"20元",@"30元",@"50元",@"100元",@"200元"];
        self.detailArr = @[@"售价：9.98元",@"售价：19.96元",@"售价：29.94元",@"售价：49.92元",@"售价99.80元",@"售价199.60元"];
        [self currentLeftMoney];
        [self currentRightMoney];
        [self phoneNumView];
        [self topMoneyNumber];
        [self topMoney];
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

- (UIView *)phoneNumView{
    if (_phoneNumView == nil) {
        _phoneNumView = [[UIView alloc] init];
        [self addSubview:_phoneNumView];
        _phoneNumView.tag = 222;
        [_phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.currentLeftMoney.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(40);
        }];
        _phoneNumView.backgroundColor = [UIColor whiteColor];
        
        UILabel *leftLB = [[UILabel alloc] init];
        [_phoneNumView addSubview:leftLB];
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        leftLB.text = @"手机号码";
        leftLB.textColor = [Utils colorRGB:@"#666666"];
        leftLB.font = [UIFont systemFontOfSize:14];
        
        UILabel *rightLB = [[UILabel alloc] init];
        [_phoneNumView addSubview:rightLB];
        [rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(leftLB.mas_right).mas_equalTo(0);
        }];
        rightLB.textAlignment = NSTextAlignmentRight;
        rightLB.text = @"请输入手机号码";
        rightLB.textColor = [Utils colorRGB:@"#cccccc"];
        rightLB.font = [UIFont systemFontOfSize:12];
        self.phoneNumberLB = rightLB;
        
        UITextField *tf = [[UITextField alloc] init];
        [_phoneNumView addSubview:tf];
        tf.tag = 1000;
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
        [tf addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];

        self.phoneNumberTF = tf;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_phoneNumView addGestureRecognizer:tap];
    }
    return _phoneNumView;
}

- (UIView *)topMoneyNumber{
    if (_topMoneyNumber == nil) {
        _topMoneyNumber = [[UIView alloc] init];
        _topMoneyNumber.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topMoneyNumber];
        [_topMoneyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneNumView.mas_bottom).mas_equalTo(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(btnWidth*hw*2 + 58);
        }];
        
        UILabel *lb = [[UILabel alloc] init];
        [_topMoneyNumber addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(16);
        }];
        lb.text = @"选择充值金额";
        lb.textColor = [Utils colorRGB:@"#666666"];
        lb.font = [UIFont systemFontOfSize:14];
        
        for (int i = 0; i < 6; i++) {
            NSInteger line = i/3;
            NSInteger queue = i%3;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15 + (btnWidth + 8)*queue, 40 + (btnWidth*hw + 8)*line, btnWidth, btnWidth*hw)];
            [_topMoneyNumber addSubview:btn];
            btn.tag = 600+i;
            btn.layer.cornerRadius = 6;
            btn.layer.borderColor = [Utils colorRGB:@"#008bd5"].CGColor;
            btn.layer.borderWidth = 1;
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArr addObject:btn];
            
            UILabel *titleLB = [[UILabel alloc] init];
            [btn addSubview:titleLB];
            titleLB.textColor = [Utils colorRGB:@"#008bd5"];
            titleLB.font = [UIFont systemFontOfSize:14];
            titleLB.text = self.titleArr[i];
            [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(btn.mas_top).mas_equalTo(btnTopDistance);
                make.centerX.mas_equalTo(0);
            }];
            
            UILabel *detailLB = [[UILabel alloc] init];
            [btn addSubview:detailLB];
            detailLB.textColor = [Utils colorRGB:@"#008bd5"];
            detailLB.font = [UIFont systemFontOfSize:11];
            detailLB.text = self.detailArr[i];
            [detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titleLB.mas_bottom).mas_equalTo(4);
                make.centerX.mas_equalTo(0);
            }];
        }
    }
    return _topMoneyNumber;
}

- (UIView *)topMoney{
    if (_topMoney == nil) {
        _topMoney = [[UIView alloc] init];
        _topMoney.tag = 111;
        [self addSubview:_topMoney];
        [_topMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.topMoneyNumber.mas_bottom).mas_equalTo(1);
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
        tf.tag = 2000;
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
        [tf addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        self.moneyNumberTF = tf;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_topMoney addGestureRecognizer:tap];
    }
    return _topMoney;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topMoney.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton setTitle:@"确认" forState:UIControlStateNormal];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.tag = 650;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""] && range.location == 0 && range.length == 1) {
        self.moneyNumberTF.text = @"";
    }
    for (UIButton *btn in self.buttonArr) {
        btn.backgroundColor = [UIColor clearColor];
        for (UILabel *lb in btn.subviews) {
            [lb setTextColor:[Utils colorRGB:@"#008bd5"]];
        }
    }
    self.money = self.moneyNumberTF.text.integerValue;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.phoneNumberTF isFirstResponder]) {
        if ([Utils isMobile:self.phoneNumberTF.text]) {
            self.phoneNumberTF.hidden = self.phoneNumberTF.hidden == NO ? YES : NO;
            self.phoneNumberLB.text = self.phoneNumberTF.text;
            self.phoneNumberLB.textColor = [Utils colorRGB:@"#666666"];
        }else{
            [Utils toastview:@"请输入正确格式手机号"];
        }
    }else{
        if ([Utils isNumber:self.moneyNumberTF.text] && ![self.moneyNumberTF.text isEqualToString:@""]) {
            for (UIButton *btn in self.buttonArr) {
                btn.backgroundColor = [UIColor clearColor];
                for (UILabel *lb in btn.subviews) {
                    [lb setTextColor:[Utils colorRGB:@"#008bd5"]];
                }
            }
            self.moneyNumberTF.hidden = self.moneyNumberTF.hidden == NO ? YES : NO;
            self.number.text = self.moneyNumberTF.text;
            self.number.textColor = [Utils colorRGB:@"#666666"];
            self.money = self.moneyNumberTF.text.integerValue;
        }else{
            [Utils toastview:@"请输入正确金额"];
        }
    }
    [self endEditing:YES];
    return YES;
}

#pragma mark - Method
- (void)textFieldDidChanged:(UITextField *)textField{
    if (textField.tag == 1000) {
        //phone
        self.phoneNumberLB.text = textField.text;
        self.phoneNumberLB.textColor = [Utils colorRGB:@"#666666"];

    }else if(textField.tag == 2000){
        //puk
        self.number.text = textField.text;
        self.number.textColor = [Utils colorRGB:@"#666666"];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 222) {
        self.phoneNumberTF.hidden = self.phoneNumberTF.hidden == NO ? YES : NO;
        self.moneyNumberTF.hidden = YES;
        [self.phoneNumberTF becomeFirstResponder];
    }else{
        self.moneyNumberTF.hidden = self.moneyNumberTF.hidden == NO ? YES : NO;
        self.phoneNumberTF.hidden = YES;
        [self.moneyNumberTF becomeFirstResponder];
    }
}

- (void)buttonClickAction:(UIButton *)button{
    if (button.tag != 650) {
        self.number.text = @"";
        self.moneyNumberTF.text = @"";
        for (UIButton *btn in self.buttonArr) {
            btn.backgroundColor = [UIColor clearColor];
            for (UILabel *lb in btn.subviews) {
                [lb setTextColor:[Utils colorRGB:@"#008bd5"]];
            }
        }
        
        for (UILabel *lb in button.subviews) {
            [lb setTextColor:[UIColor whiteColor]];
        }
        button.backgroundColor = [Utils colorRGB:@"#008bd5"];
        
        //保存充值金额
        switch (button.tag) {
            case 600:
                self.money = 10;
                break;
            case 601:
                self.money = 20;
                break;
            case 602:
                self.money = 30;
                break;
            case 603:
                self.money = 50;
                break;
            case 604:
                self.money = 100;
                break;
            case 605:
                self.money = 200;
                break;
        }
    }else{
        if (![Utils isMobile:self.phoneNumberTF.text]) {
            [Utils toastview:@"请输入正确格式手机号"];
        }else{
            if (self.money == 0) {
                [Utils toastview:@"请选择充值金额"];
            }else{
                
                self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
                self.grayView.backgroundColor = [UIColor blackColor];
                self.grayView.alpha = 0;
                [self addSubview:self.grayView];
                self.payView = [[PayView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, 500)];
                [self addSubview:self.payView];
                
                __block __weak TopCallMoneyView *weakself = self;

                [self.payView.textField becomeFirstResponder];
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect frame = self.payView.frame;
                    frame.origin.y = screenHeight - 500;
                    self.payView.frame = frame;
                    weakself.grayView.alpha = 0.4;
                }];
                
                [self.payView setPayCallBack:^(NSString *password) {
                    
                    /*
                     支付操作
                     */
                    [weakself endEditing:YES];
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect frame = weakself.payView.frame;
                        frame.origin.y = screenHeight;
                        weakself.payView.frame = frame;
                        weakself.grayView.alpha = 0;
                    } completion:^(BOOL finished) {
                        [weakself.grayView removeFromSuperview];
                    }];
                }];
                
                [self.payView setClosePayCallBack:^(id obj) {
                    [weakself endEditing:YES];
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect frame = weakself.payView.frame;
                        frame.origin.y = screenHeight;
                        weakself.payView.frame = frame;
                        weakself.grayView.alpha = 0;
                    } completion:^(BOOL finished) {
                        [weakself.grayView removeFromSuperview];
                    }];
                }];
                
                _topCallMoneyCallBack(self.money, self.phoneNumberTF.text);
            }
        }
    }
}

@end
