//
//  ForgetPasswordView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ForgetPasswordView.h"

#define leftDistance (screenWidth-171)/2.0

@implementation ForgetPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self phoneNumTF];
        [self identifyingCodeTF];
        [self nextButton];
    }
    return self;
}

- (UITextField *)phoneNumTF{
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc] init];
        [self addSubview:_phoneNumTF];
        [_phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _phoneNumTF.placeholder = @"请输入手机号";
        _phoneNumTF.textColor = [Utils colorRGB:@"#333333"];
        _phoneNumTF.font = [UIFont systemFontOfSize:14];
        _phoneNumTF.borderStyle = UITextBorderStyleNone;
        _phoneNumTF.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.image = [UIImage imageNamed:@"phone"];
        _phoneNumTF.leftView = imageV;
        _phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _phoneNumTF;
}

- (UITextField *)identifyingCodeTF{
    if (_identifyingCodeTF == nil) {
        _identifyingCodeTF = [[UITextField alloc] init];
        [self addSubview:_identifyingCodeTF];
        [_identifyingCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneNumTF.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        _identifyingCodeTF.placeholder = @"请输入验证码";
        _identifyingCodeTF.textColor = [Utils colorRGB:@"#333333"];
        _identifyingCodeTF.font = [UIFont systemFontOfSize:14];
        _identifyingCodeTF.borderStyle = UITextBorderStyleNone;
        _identifyingCodeTF.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.image = [UIImage imageNamed:@"lock"];
        _identifyingCodeTF.leftView = imageV;
        _identifyingCodeTF.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 24)];
        
        UIButton *identifyingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 24)];
        [identifyingButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [identifyingButton setTitleColor:[Utils colorRGB:@"#666666"] forState:UIControlStateNormal];
        identifyingButton.titleLabel.font = [UIFont systemFontOfSize:12];
        identifyingButton.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        identifyingButton.layer.cornerRadius = 6;
        identifyingButton.layer.masksToBounds = YES;
        identifyingButton.tag = 1104;
        [identifyingButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [v addSubview:identifyingButton];
        _identifyingCodeTF.rightView = v;
        _identifyingCodeTF.rightViewMode = UITextFieldViewModeAlways;
    }
    return _identifyingCodeTF;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftDistance);
            make.right.mas_equalTo(-leftDistance);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.identifyingCodeTF.mas_bottom).mas_equalTo(40);
        }];
        _nextButton.backgroundColor = [UIColor clearColor];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.tag = 1103;
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (void)buttonClickAction:(UIButton *)button{
    if (button.tag == 1104) {//验证码
        if (![Utils isMobile:self.phoneNumTF.text]) {
            [Utils toastview:@"请输入正确格式的手机号码"];
            return;
        }else{
            
        }
    }
    _ForgetCallBack(button.tag, self.phoneNumTF.text, self.identifyingCodeTF.text);
}


@end
