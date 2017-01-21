//
//  LoginView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self headImageView];
        [self usernameTF];
        [self passwordTF];
        [self forgetPassword];
        [self submitButton];
    }
    return self;
}

- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"logo1"];
        [self addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.height.mas_equalTo(150);
        }];
    }
    return _headImageView;
}

- (UITextField *)usernameTF{
    if (_usernameTF == nil) {
        _usernameTF = [Utils returnTextFieldWithImageName:@"user" andPlaceholder:@"请输入用户名／手机号码"];
        [self addSubview:_usernameTF];
        [_usernameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headImageView.mas_bottom).mas_equalTo(20);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
    }
    return _usernameTF;
}

- (UITextField *)passwordTF{
    if (_passwordTF == nil) {
        _passwordTF = [Utils returnTextFieldWithImageName:@"lock" andPlaceholder:@"请输入密码"];
        [self addSubview:_passwordTF];
        [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.usernameTF.mas_bottom).mas_equalTo(1);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _passwordTF.secureTextEntry = YES;
    }
    return _passwordTF;
}

- (UIButton *)forgetPassword{
    if (_forgetPassword == nil) {
        _forgetPassword = [[UIButton alloc] init];
        [self addSubview:_forgetPassword];
        [_forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwordTF.mas_bottom).mas_equalTo(6);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(14);
        }];
        [_forgetPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forgetPassword.titleLabel.font = [UIFont systemFontOfSize:textfont12];
        [_forgetPassword setTitleColor:MainColor forState:UIControlStateNormal];
        _forgetPassword.tag = 1101;
        [_forgetPassword addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPassword;
}

- (UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [Utils returnNextButtonWithTitle:@"登录"];
        [self addSubview:_submitButton];
        [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(170);
            make.top.mas_equalTo(self.forgetPassword.mas_bottom).mas_equalTo(20);
        }];
        _submitButton.tag = 1102;
        [_submitButton setTitle:@"确认" forState:UIControlStateSelected];
        [_submitButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

#pragma mark - Method
- (void)buttonClickAction:(UIButton *)button{
    if (button.tag == 1102) {
        self.submitButton.userInteractionEnabled = NO;
    }
    //1101忘记密码   1102登录
    _LoginCallBack(button.tag);
}

@end
