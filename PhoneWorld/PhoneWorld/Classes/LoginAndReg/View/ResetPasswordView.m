//
//  ResetPasswordView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ResetPasswordView.h"

@implementation ResetPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self passwordTF];
        [self passwordAgainTF];
        [self finishButton];
    }
    return self;
}

- (UITextField *)passwordTF{
    if (_passwordTF == nil) {
        _passwordTF = [Utils returnTextFieldWithImageName:@"lock" andPlaceholder:@"请输入密码"];
        [self addSubview:_passwordTF];
        [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _passwordTF.secureTextEntry = YES;
    }
    return _passwordTF;
}

- (UITextField *)passwordAgainTF{
    if (_passwordAgainTF == nil) {
        _passwordAgainTF = [Utils returnTextFieldWithImageName:@"lock" andPlaceholder:@"请再次输入密码"];
        [self addSubview:_passwordAgainTF];
        [_passwordAgainTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwordTF.mas_bottom).mas_equalTo(1);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _passwordAgainTF.secureTextEntry = YES;
    }
    return _passwordAgainTF;
}

- (UIButton *)finishButton{
    if (_finishButton == nil) {
        _finishButton = [Utils returnNextButtonWithTitle:@"完成"];
        [self addSubview:_finishButton];
        [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.passwordAgainTF.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(171);
        }];
        _finishButton.tag = 1110;
        [_finishButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishButton;
}

- (void)buttonClickAction:(UIButton *)button{
    _ResetPasswordCallBack(button.tag);
}

@end
