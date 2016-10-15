//
//  FinishCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "FinishCardView.h"

@implementation FinishCardView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self phoneLB];
        [self phoneTF];
        [self pukLB];
        [self pukButton];
        [self pukTF];
        [self nextButton];
    }
    return self;
}

- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        [self addSubview:_phoneLB];
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
        }];
        _phoneLB.text = @"手机号码：";
        _phoneLB.textColor = [Utils colorRGB:@"#333333"];
        _phoneLB.font = [UIFont systemFontOfSize:14];
    }
    return _phoneLB;
}

- (UITextField *)phoneTF{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] init];
        [self addSubview:_phoneTF];
        [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(screenWidth - 90);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
        _phoneTF.placeholder = @"请输入手机号码";
        _phoneTF.textColor = [Utils colorRGB:@"#333333"];
        _phoneTF.font = [UIFont systemFontOfSize:14];
        _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _phoneTF;
}

- (UILabel *)pukLB{
    if (_pukLB == nil) {
        _pukLB = [[UILabel alloc] init];
        [self addSubview:_pukLB];
        [_pukLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneLB.mas_bottom).mas_equalTo(35);
            make.left.mas_equalTo(10);
        }];
        _pukLB.text = @"PUK码：";
        _pukLB.textColor = [Utils colorRGB:@"#333333"];
        _pukLB.font = [UIFont systemFontOfSize:14];
    }
    return _pukLB;
}

- (UIButton *)pukButton{
    if (_pukButton == nil) {
        _pukButton = [[UIButton alloc] init];
        [self addSubview:_pukButton];
        [_pukButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(60);
        }];
        _pukButton.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_pukButton setTitle:@"校验" forState:UIControlStateNormal];
        _pukButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_pukButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _pukButton.layer.cornerRadius = 6;
        _pukButton.layer.masksToBounds = YES;
        _pukButton.tag = 750;
        [_pukButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pukButton;
}

- (UITextField *)pukTF{
    if (_pukTF == nil) {
        _pukTF = [[UITextField alloc] init];
        [self addSubview:_pukTF];
        [_pukTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(screenWidth - 160);
            make.right.mas_equalTo(self.pukButton.mas_left).mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
        _pukTF.placeholder = @"请输入PUK码";
        _pukTF.textColor = [Utils colorRGB:@"#333333"];
        _pukTF.font = [UIFont systemFontOfSize:14];
        _pukTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _pukTF;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.pukTF.mas_bottom).mas_equalTo(20);
            make.left.mas_equalTo(10);
        }];
        _nextButton.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 6;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.tag = 760;
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method
- (void)buttonClickAction:(UIButton *)button{
    if (button.tag == 750) {
        //校验按钮
    }else if(button.tag == 760){
        //下一步按钮
    }
}

@end
