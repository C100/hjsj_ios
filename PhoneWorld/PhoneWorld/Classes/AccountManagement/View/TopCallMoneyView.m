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

@end

@implementation TopCallMoneyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonArr = [NSMutableArray array];
        self.titleArr = @[@"10元",@"20元",@"30元",@"50元",@"100元",@"200元"];
        self.detailArr = @[@"售价：9.98元",@"售价：19.96元",@"售价：29.94元",@"售价：49.92元",@"售价99.80元",@"售价199.60元"];
        
        [self leftMoney];
        [self phoneNum];
        [self phoneTF];
        [self topMoney];
        self.money = 0;
        
        for (int i = 0; i < 6; i++) {
            NSInteger line = i/3;
            NSInteger queue = i%3;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10 + (btnWidth + 8)*queue, 130 + (btnWidth*hw + 8)*line, btnWidth, btnWidth*hw)];
            [self addSubview:btn];
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
        [self topButton];
    }
    return self;
}

- (void)buttonClickAction:(UIButton *)button{
    if (button.tag != 650) {
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
    }
    
    _topCallMoneyCallBack(button.tag, self.money);
    
}

- (UILabel *)leftMoney{
    if (_leftMoney == nil) {
        _leftMoney = [[UILabel alloc] init];
        [self addSubview:_leftMoney];
        [_leftMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
        }];
        _leftMoney.text = @"话费余额：";
        _leftMoney.textColor = [Utils colorRGB:@"#333333"];
        _leftMoney.font = [UIFont systemFontOfSize:14];
    }
    return _leftMoney;
}

- (UILabel *)phoneNum{
    if (_phoneNum == nil) {
        _phoneNum = [[UILabel alloc] init];
        [self addSubview:_phoneNum];
        [_phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.leftMoney.mas_bottom).mas_equalTo(29);;
            make.left.mas_equalTo(10);
        }];
        _phoneNum.text = @"手机号码：";
        _phoneNum.textColor = [Utils colorRGB:@"#333333"];
        _phoneNum.font = [UIFont systemFontOfSize:14];
    }
    return _phoneNum;
}

- (UITextField *)phoneTF{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] init];
        [self addSubview:_phoneTF];
        [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.leftMoney.mas_bottom).mas_equalTo(24);
            make.right.mas_equalTo(-50);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(screenWidth-130);
        }];
        _phoneTF.placeholder = @"请输入号码";
        _phoneTF.textColor = [Utils colorRGB:@"#333333"];
        _phoneTF.font = [UIFont systemFontOfSize:14];
        _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _phoneTF;
}

- (UILabel *)topMoney{
    if (_topMoney == nil) {
        _topMoney = [[UILabel alloc] init];
        [self addSubview:_topMoney];
        [_topMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneNum.mas_bottom).mas_equalTo(29);;
            make.left.mas_equalTo(10);
        }];
        _topMoney.text = @"充值金额：";
        _topMoney.textColor = [Utils colorRGB:@"#333333"];
        _topMoney.font = [UIFont systemFontOfSize:14];
    }
    return _topMoney;
}

- (UIButton *)topButton{
    if (_topButton == nil) {
        _topButton = [[UIButton alloc] init];
        [self addSubview:_topButton];
        [_topButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.topMoney.mas_bottom).mas_equalTo(btnWidth*hw*2 + 42);
        }];
        _topButton.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_topButton setTitle:@"确认" forState:UIControlStateNormal];
        _topButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _topButton.layer.cornerRadius = 6;
        _topButton.layer.masksToBounds = YES;
        _topButton.tag = 650;
        [_topButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topButton;
}

@end
