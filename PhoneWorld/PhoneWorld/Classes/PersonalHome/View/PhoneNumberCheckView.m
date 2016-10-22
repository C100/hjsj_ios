//
//  PhoneNumberCheckView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneNumberCheckView.h"
#import "InputView.h"

@interface PhoneNumberCheckView ()

@property (nonatomic) InputView *inputView;
@property (nonatomic) UIView *verivicationCodeView;
@property (nonatomic) UITextField *codeTF;

@end

@implementation PhoneNumberCheckView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 1, screenWidth, 40)];
        self.inputView.leftLabel.text = @"手机号码";
        self.inputView.textField.placeholder = @"请输入手机号码";
        [self addSubview:self.inputView];
        
        [self verivicationCodeView];
        [self nextButton];
    }
    return self;
}

- (UIView *)verivicationCodeView{
    if (_verivicationCodeView == nil) {
        _verivicationCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, screenWidth, 40)];
        [self addSubview:_verivicationCodeView];
        _verivicationCodeView.backgroundColor = [UIColor whiteColor];
        
        UILabel *leftLB = [[UILabel alloc] init];
        [_verivicationCodeView addSubview:leftLB];
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(16);
        }];
        leftLB.text = @"验证码";
        leftLB.font = [UIFont systemFontOfSize:14];
        leftLB.textColor = [Utils colorRGB:@"#666666"];
        
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
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(sendVericicationCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UITextField *codeTF = [[UITextField alloc] init];
        [_verivicationCodeView addSubview:codeTF];
        [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(button.mas_left).mas_equalTo(-10);
            make.left.mas_equalTo(leftLB.mas_right).mas_equalTo(10);
        }];
        codeTF.placeholder = @"请输入验证码";
        codeTF.font = [UIFont systemFontOfSize:12];
        codeTF.textColor = [Utils colorRGB:@"#333333"];
        codeTF.textAlignment = NSTextAlignmentRight;
        self.codeTF = codeTF;
    }
    return _verivicationCodeView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.verivicationCodeView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method

- (void)sendVericicationCodeAction:(UIButton *)button{
    //发送验证码
    if ([Utils isMobile:self.inputView.textField.text]) {
        NSLog(@"--------------发送验证码");
    }else{
        [Utils toastview:@"请输入正确格式的手机号"];
    }
}

- (void)buttonClickAction:(UIButton *)button{
    if ([self.inputView.textField.text isEqualToString:@""]) {
        [Utils toastview:@"请输入手机号"];
        return;
    }
    if (![Utils isMobile:self.inputView.textField.text]) {
        [Utils toastview:@"请输入正确格式的手机号"];
        return;
    }
    if ([self.codeTF.text isEqualToString:@""]) {
        [Utils toastview:@"请输入验证码"];
        return;
    }
    NSLog(@"------------下一步");
}

@end
