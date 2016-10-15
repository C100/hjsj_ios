//
//  LoginView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "LoginView.h"

#define leftDistance (screenWidth - 170)/2

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self usernameTF];
        [self passwordTF];
        [self textLB];
        [self registerBtn];
        [self forgetPassword];
        [self submitButton];
    }
    return self;
}

- (UITextField *)usernameTF{
    if (_usernameTF == nil) {
        _usernameTF = [[UITextField alloc] init];
        [self addSubview:_usernameTF];
        [_usernameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _usernameTF.placeholder = @"请输入用户名／手机号码";
        _usernameTF.textColor = [Utils colorRGB:@"#333333"];
        _usernameTF.font = [UIFont systemFontOfSize:14];
        _usernameTF.borderStyle = UITextBorderStyleNone;
        _usernameTF.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.image = [UIImage imageNamed:@"user"];
        _usernameTF.leftView = imageV;
        _usernameTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _usernameTF;
}

- (UITextField *)passwordTF{
    if (_passwordTF == nil) {
        _passwordTF = [[UITextField alloc] init];
        [self addSubview:_passwordTF];
        [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.usernameTF.mas_bottom).mas_equalTo(1);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.secureTextEntry = YES;
        _passwordTF.textColor = [Utils colorRGB:@"#333333"];
        _passwordTF.font = [UIFont systemFontOfSize:14];
        _passwordTF.borderStyle = UITextBorderStyleNone;
        _passwordTF.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.image = [UIImage imageNamed:@"lock"];
        _passwordTF.leftView = imageV;
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _passwordTF;
}

- (UILabel *)textLB{
    if (_textLB == nil) {
        _textLB = [[UILabel alloc] init];
        [self addSubview:_textLB];
        [_textLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwordTF.mas_bottom).mas_equalTo(6);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(75);
        }];
        _textLB.text = @"还没有账号？";
        _textLB.textColor = [Utils colorRGB:@"#666666"];
        _textLB.font = [UIFont systemFontOfSize:12];
    }
    return _textLB;
}

- (UIButton *)registerBtn{
    if (_registerBtn == nil) {
        _registerBtn = [[UIButton alloc] init];
        [self addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwordTF.mas_bottom).mas_equalTo(6);
            make.left.mas_equalTo(self.textLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(14);
        }];
        [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_registerBtn setTitleColor:[Utils colorRGB:@"#008bd5"] forState:UIControlStateNormal];
        _registerBtn.tag = 1100;
        [_registerBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIButton *)forgetPassword{
    if (_forgetPassword == nil) {
        _forgetPassword = [[UIButton alloc] init];
        [self addSubview:_forgetPassword];
        [_forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwordTF.mas_bottom).mas_equalTo(6);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(14);
        }];
        [_forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetPassword.titleLabel.font = [UIFont systemFontOfSize:12];
        [_forgetPassword setTitleColor:[Utils colorRGB:@"#008bd5"] forState:UIControlStateNormal];
        _forgetPassword.tag = 1101;
        [_forgetPassword addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPassword;
}

- (UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [[UIButton alloc] init];
        [self addSubview:_submitButton];
        [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftDistance);
            make.right.mas_equalTo(-leftDistance);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(170);
            make.top.mas_equalTo(self.textLB.mas_bottom).mas_equalTo(20);
        }];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_submitButton setTitleColor:MainColor forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 20;
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.borderColor = MainColor.CGColor;
        _submitButton.layer.borderWidth = 1;
        _submitButton.tag = 1102;
        [_submitButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

#pragma mark - Method
- (void)buttonClickAction:(UIButton *)button{
    _LoginCallBack(button.tag);
}

@end
