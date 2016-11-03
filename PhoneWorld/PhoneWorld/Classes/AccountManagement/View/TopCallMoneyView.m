//
//  TopCallMoneyView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopCallMoneyView.h"
#import "InputView.h"
//#import "ForgetPasswordViewController.h"
#import "TopResultViewController.h"

#define btnWidth (screenWidth - 46)/3.0
#define hw 70/113.0
#define btnTopDistance (btnWidth*hw - 16 - 4 - 13)/2.0

@interface TopCallMoneyView ()

@property (nonatomic) NSArray *titleArr;
@property (nonatomic) NSArray *detailArr;
@property (nonatomic) NSMutableArray *buttonArr;
@property (nonatomic) NSInteger money;
@property (nonatomic) UIView *grayView;
@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) InputView *topMoney;

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
        self.inputViews = [NSMutableArray array];
        self.leftTitles = @[@"当前余额",@"手机号码"];
        for (int i = 0; i < 2; i ++) {
            InputView *inputV = [[InputView alloc] initWithFrame:CGRectMake(0, 50*i, screenWidth, 40)];
            [self addSubview:inputV];
            inputV.leftLabel.text = self.leftTitles[i];
            if (i == 0) {
                inputV.textField.text = @"99元";
                inputV.textField.userInteractionEnabled = NO;
            }else{
                inputV.textField.placeholder = @"请输入手机号码";
            }
            [self.inputViews addObject:inputV];
        }
        [self topMoneyNumber];
        [self topMoney];
        [self nextButton];
    }
    return self;
}

- (UIView *)topMoneyNumber{
    if (_topMoneyNumber == nil) {
        _topMoneyNumber = [[UIView alloc] init];
        _topMoneyNumber.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topMoneyNumber];
        InputView *inputV = self.inputViews.lastObject;
        [_topMoneyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(inputV.mas_bottom).mas_equalTo(10);
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

- (InputView *)topMoney{
    if (_topMoney == nil) {
        _topMoney = [[InputView alloc] init];
        [self addSubview:_topMoney];
        [_topMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.topMoneyNumber.mas_bottom).mas_equalTo(1);;
        }];
        _topMoney.leftLabel.text = @"其它充值金额";
        _topMoney.textField.placeholder = @"请输入金额";
        _topMoney.textField.delegate = self;
    }
    return _topMoney;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnBextButtonWithTitle:@"确认"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topMoney.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        _nextButton.tag = 650;
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    for (UIButton *btn in self.buttonArr) {
        btn.backgroundColor = [UIColor clearColor];
        for (UILabel *lb in btn.subviews) {
            [lb setTextColor:[Utils colorRGB:@"#008bd5"]];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

#pragma mark - Method

- (void)buttonClickAction:(UIButton *)button{
    if (button.tag != 650) {
        self.topMoney.textField.text = @"";
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
        InputView *phoneView = self.inputViews.lastObject;
        if (![Utils isMobile:phoneView.textField.text]) {
            [Utils toastview:@"请输入正确格式手机号"];
        }else{
            if (self.money == 0 && [self.topMoney.textField.text isEqualToString:@""]) {
                [Utils toastview:@"请选择充值金额"];
            }else{
                if (![self.topMoney.textField.text isEqualToString:@""]) {
                    self.money = self.topMoney.textField.text.integerValue;
                }
                self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
                self.grayView.backgroundColor = [UIColor blackColor];
                self.grayView.alpha = 0;
                [self addSubview:self.grayView];
                self.payView = [[PayView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, 450)];
                [self addSubview:self.payView];
                
                __block __weak TopCallMoneyView *weakself = self;

                [self.payView.textField becomeFirstResponder];
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect frame = self.payView.frame;
                    frame.origin.y = screenHeight - 450;
                    self.payView.frame = frame;
                    weakself.grayView.alpha = 0.4;
                }];
                
                [self.payView setPayCallBack:^(NSString *password) {
                    /*
                     输入完毕，支付操作
                     */
                    [weakself endEditing:YES];
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect frame = weakself.payView.frame;
                        frame.origin.y = screenHeight;
                        weakself.payView.frame = frame;
                        weakself.grayView.alpha = 0;
                    } completion:^(BOOL finished) {
                        [weakself.grayView removeFromSuperview];
                        
                        [[weakself viewController].navigationController pushViewController:[TopResultViewController new] animated:YES];
                        
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
                _topCallMoneyCallBack(self.money, phoneView.textField.text);
            }
        }
    }
}

@end
