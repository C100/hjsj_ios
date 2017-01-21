//
//  RegisterView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RegisterView.h"
#import "InputView.h"
#import "ChooseImageView.h"
#import "LoginViewController.h"
#import "RegisterModel.h"

@interface RegisterView ()<UITextFieldDelegate>

@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSArray *details;
@property (nonatomic) NSArray *channelType;
@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) ChooseImageView *chooseImageView;
@property (nonatomic) InputView *channelNameInputView;//渠道名称inputview
@property (nonatomic) UIButton *captchaButton;//验证码按钮
@property (nonatomic) CADisplayLink *link;//一分钟倒计时

@property (nonatomic) AddressPickerView *addressPickerView;
@property (nonatomic) UIView *pickerBackView;
@property (nonatomic) UIButton *sureButton;
@property (nonatomic) UIButton *cancelButton;
@property (nonatomic) InputView *addressInputView;

@end

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.contentSize = CGSizeMake(screenWidth, 680);
        self.bounces = NO;
        self.leftTitles = @[@"＊用户名",@"＊密码",@"＊真实姓名",@"＊身份证号码",@"＊手机号码",@"＊验证码",@"邮箱",@"＊渠道类型",@"＊渠道名称",@"＊渠道地址",@"＊详细地址",@"＊上级推荐码"];
        self.details = @[@"请输入用户名",@"请输入6-12位数字字母密码",@"请输入真实姓名",@"请输入身份证号码",@"请输入手机号",@"请输入验证码",@"请输入有效邮箱",@"请选择",@"请输入渠道名称",@"请输入渠道地址",@"请输入详细地址",@"请输入上级推荐码"];
        self.channelType = @[@"总代理",@"一级代理",@"二级代理",@"渠道商"];
        
        self.inputViews = [NSMutableArray array];
        
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDownAction)];
        self.link.frameInterval = 60;
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.link.paused = YES;
        
        for (int i = 0; i < self.leftTitles.count; i++) {
            
            InputView *inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:inputView];
            inputView.leftLabel.text = self.leftTitles[i];
            NSRange range = [inputView.leftLabel.text rangeOfString:@"＊"];
            inputView.leftLabel.attributedText = [Utils setTextColor:inputView.leftLabel.text FontNumber:[UIFont systemFontOfSize:textfont10] AndRange:range AndColor:MainColor];
            inputView.textField.placeholder = self.details[i];
            inputView.textField.delegate = self;
            [self.inputViews addObject:inputView];
            inputView.textField.tag = 10 + i;

            
            if ([self.leftTitles[i] isEqualToString:@"＊验证码"]) {
                UIButton *identifyingButton = [[UIButton alloc] init];
                [identifyingButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [identifyingButton setTitleColor:[Utils colorRGB:@"#666666"] forState:UIControlStateNormal];
                identifyingButton.titleLabel.font = [UIFont systemFontOfSize:textfont12];
                identifyingButton.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
                identifyingButton.layer.cornerRadius = 6;
                identifyingButton.layer.masksToBounds = YES;
                [identifyingButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
                [inputView addSubview:identifyingButton];
                [identifyingButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-15);
                    make.centerY.mas_equalTo(0);
                    make.width.mas_equalTo(85);
                    make.height.mas_equalTo(24);
                }];
                self.captchaButton = identifyingButton;
                [inputView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(0);
                    make.right.mas_equalTo(identifyingButton.mas_left).mas_equalTo(-10);
                    make.left.mas_equalTo(inputView.leftLabel.mas_right).mas_equalTo(0);
                    make.height.mas_equalTo(30);
                }];
            }
            
            if ([self.leftTitles[i] isEqualToString:@"＊渠道类型"]) {
                inputView.textField.enabled = NO;
                UIButton *rightButton = [[UIButton alloc] init];
                [inputView addSubview:rightButton];
                [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(0);
                    make.right.mas_equalTo(-15);
                    make.width.mas_equalTo(10);
                    make.height.mas_equalTo(16);
                }];
                [rightButton setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseChannelTypeAction:)];
                [inputView addGestureRecognizer:tap];
                
                [inputView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(0);
                    make.right.mas_equalTo(rightButton.mas_left).mas_equalTo(-10);
                    make.left.mas_equalTo(inputView.leftLabel.mas_right).mas_equalTo(10);
                    make.height.mas_equalTo(30);
                }];
            }
            
            if ([self.leftTitles[i] isEqualToString:@"＊渠道名称"]) {
                self.channelNameInputView = inputView;
                inputView.textField.enabled = NO;
                UITapGestureRecognizer *tapChannelNameInputView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChannelNameInputViewAction:)];
                [self.channelNameInputView addGestureRecognizer:tapChannelNameInputView];
            }
            
            
            if ([self.leftTitles[i] isEqualToString:@"＊渠道地址"]) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAddressAction:)];
                inputView.textField.enabled = NO;
                [inputView addGestureRecognizer:tap];
                self.addressInputView = inputView;
            }
            
            if ([self.leftTitles[i] isEqualToString:@"＊手机号码"]) {
                inputView.textField.keyboardType = UIKeyboardTypeNumberPad;
            }
        }
        [self chooseImageView];
        [self nextButton];
        
        UIView *leftWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 15, 399.5)];
        leftWhiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:leftWhiteView];
    }
    return self;
}

- (ChooseImageView *)chooseImageView{
    if (_chooseImageView == nil) {
        _chooseImageView = [[ChooseImageView alloc] initWithFrame:CGRectZero andTitle:@"图片（点击图片可放大）" andDetail:@[@"营业执照照片\n(选填)",@"手持身份证正面照"] andCount:2];
        [self addSubview:_chooseImageView];
        InputView *lastInputView = self.inputViews.lastObject;
        [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lastInputView.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(185);
        }];
    }
    return _chooseImageView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"确定"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.chooseImageView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
            make.bottom.mas_equalTo(-40);
        }];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

//选择渠道类型
- (void)chooseChannelTypeAction:(UITapGestureRecognizer *)tap{
    InputView *inputView = (InputView *)tap.view;
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"渠道类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < self.channelType.count; i++) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.channelType[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            inputView.textField.text = self.channelType[i];
            self.channelNameInputView.textField.enabled = YES;
        }];
        [ac addAction:action1];
    }
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:action2];
    UIViewController *viewController = [self viewController];
    [viewController presentViewController:ac animated:YES completion:nil];
}

- (void)buttonClickAction:(UIButton *)button{
    if ([button.currentTitle isEqualToString:@"确定"]) {
        
        NSString *phoneNumberString = nil;
        NSString *captchaString = nil;
        
        for (int i = 0; i < self.inputViews.count; i++) {
            InputView *inputV = self.inputViews[i];
            //判断是否为空
            if ([inputV.leftLabel.text isEqualToString:@"邮箱"]) {
                
            }else{
                if ([inputV.textField.text isEqualToString:@""]) {
                    NSString *string = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
                    if (i == 7) {
                        string = [string stringByReplacingOccurrencesOfString:@"请输入" withString:@"请选择"];
                    }
                    string = [string stringByReplacingOccurrencesOfString:@"＊" withString:@""];
                    [Utils toastview:string];
                    return;
                }
            }
            
            if (![inputV.leftLabel.text isEqualToString:@"邮箱"] && ![inputV.leftLabel.text isEqualToString:@"＊渠道地址"]) {
                if ([Utils isRightString:inputV.textField.text] == NO) {
                    [Utils toastview:@"请输入数字、字母、中文或下划线！"];
                    return;
                }
            }
            
            
            //判断格式是否正确
            
            if ([inputV.leftLabel.text isEqualToString:@"＊用户名"]) {
                if ([Utils isNumber:inputV.textField.text]) {
                    [Utils toastview:@"用户名不得全是数字！"];
                    return;
                }
            }
            
            if ([inputV.leftLabel.text isEqualToString:@"＊密码"]) {
                if (![Utils checkPassword:inputV.textField.text]) {
                    [Utils toastview:@"密码必须包含数字和字母，且不得少于6位大于12位"];
                    return;
                }
            }
            if ([inputV.leftLabel.text isEqualToString:@"＊身份证号码"]) {
                if (![Utils isIDNumber:inputV.textField.text]) {
                    [Utils toastview:@"请输入正确身份证号码"];
                    return;
                }
            }
            if ([inputV.leftLabel.text isEqualToString:@"＊手机号码"]) {
                phoneNumberString = inputV.textField.text;
                if (![Utils isMobile:inputV.textField.text]) {
                    [Utils toastview:@"请输入正确手机号"];
                    return;
                }
            }
            if ([inputV.leftLabel.text isEqualToString:@"＊验证码"]) {
                captchaString = inputV.textField.text;
                
                if (![Utils isNumber:inputV.textField.text]) {
                    [Utils toastview:@"验证码格式不正确"];
                    return;
                }
            }
            if ([inputV.leftLabel.text isEqualToString:@"邮箱"] && ![inputV.textField.text isEqualToString:@""]) {
                if (![Utils isEmailAddress:inputV.textField.text]) {
                    [Utils toastview:@"请输入正确邮箱"];
                    return;
                }
            }
        }
        
        NSMutableArray *regArr = [NSMutableArray array];
        for (int i = 0; i < self.inputViews.count; i ++) {
            InputView *inputV = self.inputViews[i];
            if ([inputV.textField.text isEqualToString:@""]) {
                [regArr addObject:@"无"];
            }else{
                if ([inputV.leftLabel.text isEqualToString:@"＊渠道地址"]) {
                    [regArr addObject:self.currentProvinceModel.provinceId];
                    [regArr addObject:self.currentCityModel.cityId];
                }else{
                    [regArr addObject:inputV.textField.text];
                }
            }
        }
        
        for (int i = 0; i < 2; i++) {
            UIImageView *imageV = self.chooseImageView.imageViews[i];
            if (imageV.hidden == YES || !imageV.image) {
                [regArr addObject:@"无"];
            }else{
                [regArr addObject:[Utils imagechange:imageV.image]];
            }
        }
        
        RegisterModel *regModel = [[RegisterModel alloc] initWithArray:regArr];
        
        [self endEditing:YES];
        
        //注册操作
        _registerCallBack(regModel,phoneNumberString,captchaString);
        
    }else{
        //获取验证码
        
        InputView *inputView = self.inputViews[4];
        NSString *phone = inputView.textField.text;
        
        
        if ([Utils isMobile:phone]) {
            
            //一分钟倒计时action
            [self.captchaButton setTitle:@"60秒" forState:UIControlStateNormal];
            self.link.paused = NO;
            self.captchaButton.userInteractionEnabled = NO;
            
            //发送验证码
            [WebUtils requestSendCaptchaWithType:1 andTel:phone andCallBack:^(id obj) {
                if (obj) {
                    NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                    if ([code isEqualToString:@"10000"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:@"验证码已发送"];
                        });
                    }else{
                        NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:mes];
                        });
                    }
                }
            }];
            
        }else{
            [Utils toastview:@"请输入正确格式手机号"];
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

- (void)tapChannelNameInputViewAction:(UITapGestureRecognizer *)tap{
    if (self.channelNameInputView.textField.enabled == NO) {
        [Utils toastview:@"请选择渠道类型"];
    }
}

- (void)chooseAddressAction:(UITapGestureRecognizer *)tap{
    [self endEditing:YES];
    /*显示背景灰色视图*/
    self.pickerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.pickerBackView.backgroundColor = [UIColor blackColor];
    self.pickerBackView.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:self.pickerBackView];
    UITapGestureRecognizer *tapBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAddressPickerAction)];
    [self.pickerBackView addGestureRecognizer:tapBack];
    /*显示地址选择器*/
    self.addressPickerView = [[AddressPickerView alloc] initWithFrame:CGRectMake(0, screenHeight - 250, screenWidth, 250)];
    self.addressPickerView.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.addressPickerView];
    /*确定按钮 和 取消按钮*/
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 100, screenHeight - 250, 100, 30)];
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[Utils colorRGB:@"#0081eb"] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(pickerClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:self.sureButton];
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, screenHeight - 250, 100, 30)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[Utils colorRGB:@"#0081eb"] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(pickerClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:self.cancelButton];
}

- (void)dismissAddressPickerAction{
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerBackView.alpha = 0;
        self.addressPickerView.alpha = 0;
        self.sureButton.alpha = 0;
        self.cancelButton.alpha = 0;
    } completion:^(BOOL finished) {
        [self.pickerBackView removeFromSuperview];
        [self.addressPickerView removeFromSuperview];
        [self.cancelButton removeFromSuperview];
        [self.sureButton removeFromSuperview];
    }];
}

- (void)pickerClickedAction:(UIButton *)button{
    if ([button.currentTitle isEqualToString:@"确定"]) {
        self.currentCityModel = self.addressPickerView.currentCityModel;
        self.currentProvinceModel = self.addressPickerView.currentProvinceModel;
        self.addressInputView.textField.text = [NSString stringWithFormat:@"%@ %@",self.addressPickerView.currentProvinceModel.provinceName,self.addressPickerView.currentCityModel.cityName];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerBackView.alpha = 0;
        self.addressPickerView.alpha = 0;
        self.sureButton.alpha = 0;
        self.cancelButton.alpha = 0;
    } completion:^(BOOL finished) {
        [self.pickerBackView removeFromSuperview];
        [self.addressPickerView removeFromSuperview];
        [self.cancelButton removeFromSuperview];
        [self.sureButton removeFromSuperview];
    }];
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 10 || textField.tag == 12) {
        if (textField.text.length >= 30) {
            return NO;
        }
    }
    
    if (textField.tag == 11) {
        if (textField.text.length >= 12) {
            return NO;
        }
    }
    return YES;
}

@end
