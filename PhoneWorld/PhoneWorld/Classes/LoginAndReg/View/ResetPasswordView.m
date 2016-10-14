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
        _passwordTF = [[UITextField alloc] init];
        [self addSubview:_passwordTF];
        [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
        }];
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.textColor = [Utils colorRGB:@"#333333"];
        _passwordTF.font = [UIFont systemFontOfSize:14];
        _passwordTF.borderStyle = UITextBorderStyleNone;
        _passwordTF.backgroundColor = [UIColor whiteColor];
        _passwordTF.secureTextEntry = YES;
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.image = [UIImage imageNamed:@"lock"];
        _passwordTF.leftView = imageV;
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _passwordTF;
}

- (UITextField *)passwordAgainTF{
    if (_passwordAgainTF == nil) {
        _passwordAgainTF = [[UITextField alloc] init];
        [self addSubview:_passwordAgainTF];
        [_passwordAgainTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwordTF.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
        }];
        _passwordAgainTF.placeholder = @"请再次输入密码";
        _passwordAgainTF.textColor = [Utils colorRGB:@"#333333"];
        _passwordAgainTF.font = [UIFont systemFontOfSize:14];
        _passwordAgainTF.borderStyle = UITextBorderStyleNone;
        _passwordAgainTF.backgroundColor = [UIColor whiteColor];
        _passwordAgainTF.secureTextEntry = YES;
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.image = [UIImage imageNamed:@"lock"];
        _passwordAgainTF.leftView = imageV;
        _passwordAgainTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _passwordAgainTF;
}

- (UIButton *)finishButton{
    if (_finishButton == nil) {
        _finishButton = [[UIButton alloc] init];
        [self addSubview:_finishButton];
        [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.passwordAgainTF.mas_bottom).mas_equalTo(20);
        }];
        _finishButton.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        _finishButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishButton.layer.cornerRadius = 6;
        _finishButton.layer.masksToBounds = YES;
        _finishButton.tag = 1110;
        [_finishButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishButton;
}

- (void)buttonClickAction:(UIButton *)button{
    _ResetPasswordCallBack(button.tag);
}

@end
