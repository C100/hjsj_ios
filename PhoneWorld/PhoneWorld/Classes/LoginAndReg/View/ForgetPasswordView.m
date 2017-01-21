//
//  ForgetPasswordView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ForgetPasswordView.h"

#define leftDistance (screenWidth-171)/2.0

@interface ForgetPasswordView ()<UITextFieldDelegate>

@property (nonatomic) UIButton *captchaButton;
@property (nonatomic) CADisplayLink *link;

@end

@implementation ForgetPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isChecked = NO;
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDownAction)];
        self.link.frameInterval = 60;
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.link.paused = YES;
        
        [self phoneNumTF];
        [self identifyingCodeTF];
        [self nextButton];
    }
    return self;
}

- (UITextField *)phoneNumTF{
    if (_phoneNumTF == nil) {
        _phoneNumTF = [Utils returnTextFieldWithImageName:@"phone" andPlaceholder:@"请输入手机号"];
        _phoneNumTF.delegate = self;
        [self addSubview:_phoneNumTF];
        [_phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
    }
    return _phoneNumTF;
}

- (UITextField *)identifyingCodeTF{
    if (_identifyingCodeTF == nil) {
        _identifyingCodeTF = [Utils returnTextFieldWithImageName:@"lock" andPlaceholder:@"请输入验证码"];
        [self addSubview:_identifyingCodeTF];
        [_identifyingCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneNumTF.mas_bottom).mas_equalTo(1);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 24)];
        
        UIButton *identifyingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 24)];
        [identifyingButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [identifyingButton setTitleColor:[Utils colorRGB:@"#666666"] forState:UIControlStateNormal];
        identifyingButton.titleLabel.font = [UIFont systemFontOfSize:textfont12];
        identifyingButton.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        identifyingButton.layer.cornerRadius = 6;
        identifyingButton.layer.masksToBounds = YES;
        identifyingButton.tag = 1104;
        [identifyingButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [v addSubview:identifyingButton];
        
        _identifyingCodeTF.rightView = v;
        _identifyingCodeTF.rightViewMode = UITextFieldViewModeAlways;
        self.captchaButton = identifyingButton;
    }
    return _identifyingCodeTF;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"下一步"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftDistance);
            make.right.mas_equalTo(-leftDistance);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.identifyingCodeTF.mas_bottom).mas_equalTo(40);
        }];
        _nextButton.tag = 1103;
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (void)buttonClickAction:(UIButton *)button{
    if (![Utils isMobile:self.phoneNumTF.text]) {
        [Utils toastview:@"请输入正确格式的手机号码"];
        return;
    }
    if (button.tag == 1103) {//下一步
        if (![Utils isNumber:self.identifyingCodeTF.text] || [self.identifyingCodeTF.text isEqualToString:@""]) {
            [Utils toastview:@"请输入验证码"];
            return;
        }
        _ForgetCallBack(button.tag, self.phoneNumTF.text, self.identifyingCodeTF.text);
    }else{
        
        
        self.captchaButton.userInteractionEnabled = NO;

        
        if (self.isChecked == NO) {
            __block __weak ForgetPasswordView *weakself = self;
            if (![self.phoneNumTF.text isEqualToString:@""]) {
                [WebUtils requestIsHJSJNumberWithNumber:weakself.phoneNumTF.text andCallBack:^(id obj) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.captchaButton.userInteractionEnabled = YES;
                    });
                    if (obj) {
                        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                        if ([code isEqualToString:@"10000"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                weakself.isChecked = YES;
                                //一分钟倒计时action
                                [weakself.captchaButton setTitle:@"60秒" forState:UIControlStateNormal];
                                weakself.link.paused = NO;
                                
                                _ForgetCallBack(button.tag, weakself.phoneNumTF.text, weakself.identifyingCodeTF.text);
                            });
                        }else{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [Utils toastview:@"请输入正确手机号！"];
                            });
                        }
                    }
                }];
            }
        }else{
            //一分钟倒计时action
            [self.captchaButton setTitle:@"60秒" forState:UIControlStateNormal];
            self.link.paused = NO;
            
            _ForgetCallBack(button.tag, self.phoneNumTF.text, self.identifyingCodeTF.text);
        }
        
    }
}

- (void)countDownAction{
    if ([self.captchaButton.currentTitle isEqualToString:@"0秒"]) {
        [self.captchaButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.link.paused = YES;
        self.captchaButton.userInteractionEnabled = YES;
        return;
    }
    NSString *titleString = [self.captchaButton.currentTitle componentsSeparatedByString:@"秒"].firstObject;
    int titleNumber = [titleString intValue] - 1;
    NSString *changeTitle = [NSString stringWithFormat:@"%d秒",titleNumber];
    [self.captchaButton setTitle:changeTitle forState:UIControlStateNormal];
}

#pragma mark - UITextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.captchaButton.userInteractionEnabled = NO;
    __block __weak ForgetPasswordView *weakself = self;
    if (![textField.text isEqualToString:@""]) {
        [WebUtils requestIsHJSJNumberWithNumber:textField.text andCallBack:^(id obj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.captchaButton.userInteractionEnabled = YES;
            });
            if (obj) {
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.isChecked = YES;
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:@"请输入正确手机号！"];
                    });
                }
            }
        }];
    }
}
@end
