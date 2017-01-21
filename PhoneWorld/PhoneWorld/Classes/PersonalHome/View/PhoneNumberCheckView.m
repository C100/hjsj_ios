//
//  PhoneNumberCheckView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneNumberCheckView.h"

@interface PhoneNumberCheckView ()

@property (nonatomic) UIView *verivicationCodeView;
@property (nonatomic) UIButton *captchaButton;//验证码按钮
@property (nonatomic) CADisplayLink *link;

@end

@implementation PhoneNumberCheckView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        
        [self verivicationCodeView];
        [self nextButton];
        
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDownAction)];
        self.link.frameInterval = 60;
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.link.paused = YES;
    }
    return self;
}

- (UIView *)verivicationCodeView{
    if (_verivicationCodeView == nil) {
        _verivicationCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        [self addSubview:_verivicationCodeView];
        _verivicationCodeView.backgroundColor = [UIColor whiteColor];
        
        UILabel *leftLB = [[UILabel alloc] init];
        [_verivicationCodeView addSubview:leftLB];
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(60);
        }];
        leftLB.text = @"验证码";
        leftLB.font = [UIFont systemFontOfSize:textfont16];
        leftLB.textColor = [UIColor blackColor];
        
        UIButton *button = [[UIButton alloc] init];
        [_verivicationCodeView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(24);
        }];
        button.layer.cornerRadius = 6;
        button.layer.masksToBounds = YES;
        button.backgroundColor = COLOR_BACKGROUND;
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button setTitleColor:[Utils colorRGB:@"#666666"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:textfont12];
        [button addTarget:self action:@selector(sendVericicationCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        self.captchaButton = button;
        
        UITextField *codeTF = [[UITextField alloc] init];
        [_verivicationCodeView addSubview:codeTF];
        [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(button.mas_left).mas_equalTo(-10);
            make.left.mas_equalTo(leftLB.mas_right).mas_equalTo(10);
        }];
        codeTF.placeholder = @"请输入验证码";
        codeTF.font = [UIFont systemFontOfSize:textfont16];

        [codeTF setValue:[UIFont systemFontOfSize:textfont12] forKeyPath:@"_placeholderLabel.font"];
        [codeTF setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];

        codeTF.textColor = [Utils colorRGB:@"#333333"];
        codeTF.textAlignment = NSTextAlignmentRight;
        self.codeTF = codeTF;
    }
    return _verivicationCodeView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"下一步"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.verivicationCodeView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method

- (void)sendVericicationCodeAction:(UIButton *)button{
    //发送验证码
    _sendCaptchaCallBack(button);
    
    [self.captchaButton setTitle:@"60秒" forState:UIControlStateNormal];
    self.link.paused = NO;
    self.captchaButton.userInteractionEnabled = NO;
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

- (void)buttonClickAction:(UIButton *)button{
    if ([self.codeTF.text isEqualToString:@""]) {
        [Utils toastview:@"请输入验证码"];
        return;
    }
    _nextStepCallBack(button);
}

@end
