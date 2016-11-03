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
//#import "FailedView.h"
#import "LoginViewController.h"
#import "RegisterModel.h"

@interface RegisterView ()

@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSArray *details;
@property (nonatomic) NSArray *channelType;
@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) ChooseImageView *chooseImageView;
//@property (nonatomic) FailedView *resultView;
@property (nonatomic) InputView *channelNameInputView;

@end

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.contentSize = CGSizeMake(screenWidth, 680);
        self.bounces = NO;
        self.leftTitles = @[@"＊用户名",@"＊密码",@"＊真实姓名",@"＊身份证号码",@"＊手机号码",@"＊验证码",@"邮箱",@"＊渠道类型",@"＊渠道名称",@"＊上级推荐码"];
        self.details = @[@"请输入用户名",@"请输入密码",@"请输入真实姓名",@"请输入身份证号码",@"请输入手机号",@"请输入验证码",@"请输入有效邮箱",@"请选择",@"请输入渠道名称",@"请输入上级推荐码"];
        self.channelType = @[@"总代理",@"一级代理",@"二级代理",@"渠道商"];
        self.inputViews = [NSMutableArray array];
        
        for (int i = 0; i < self.leftTitles.count; i++) {
            InputView *inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:inputView];
            inputView.leftLabel.text = self.leftTitles[i];
            NSRange range = [inputView.leftLabel.text rangeOfString:@"＊"];
            inputView.leftLabel.attributedText = [Utils setTextColor:inputView.leftLabel.text FontNumber:[UIFont systemFontOfSize:10] AndRange:range AndColor:MainColor];
            inputView.textField.placeholder = self.details[i];
            [self.inputViews addObject:inputView];
            
            if ([self.leftTitles[i] isEqualToString:@"＊验证码"]) {
                UIButton *identifyingButton = [[UIButton alloc] init];
                [identifyingButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [identifyingButton setTitleColor:[Utils colorRGB:@"#666666"] forState:UIControlStateNormal];
                identifyingButton.titleLabel.font = [UIFont systemFontOfSize:12];
                identifyingButton.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
                identifyingButton.layer.cornerRadius = 6;
                identifyingButton.layer.masksToBounds = YES;
                identifyingButton.tag = 10;
                [identifyingButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
                [inputView addSubview:identifyingButton];
                [identifyingButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-15);
                    make.centerY.mas_equalTo(0);
                    make.width.mas_equalTo(70);
                    make.height.mas_equalTo(24);
                }];
                [inputView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(0);
                    make.right.mas_equalTo(identifyingButton.mas_left).mas_equalTo(-10);
                    make.left.mas_equalTo(inputView.leftLabel.mas_right).mas_equalTo(10);
                    make.height.mas_equalTo(30);
                }];
            }
            
            if ([self.leftTitles[i] isEqualToString:@"＊渠道类型"]) {
                inputView.textField.enabled = NO;
                UIButton *rightButton = [[UIButton alloc] init];
                [inputView addSubview:rightButton];
                [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(0);
                    make.left.mas_equalTo(inputView.leftLabel.mas_right).mas_equalTo(10);
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
        }
        [self chooseImageView];
        [self nextButton];
        
        UIView *leftWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 400)];
        leftWhiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:leftWhiteView];
    }
    return self;
}

- (ChooseImageView *)chooseImageView{
    if (_chooseImageView == nil) {
        _chooseImageView = [[ChooseImageView alloc] initWithFrame:CGRectZero andTitle:@"图片（点击图片可放大）" andDetail:@[@"营业执照照片(选填)",@"手持身份证正面照",@"身份证背面照"] andCount:3];
        [self addSubview:_chooseImageView];
        InputView *lastInputView = self.inputViews.lastObject;
        [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lastInputView.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(130);
        }];
    }
    return _chooseImageView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnBextButtonWithTitle:@"确定"];
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
        NSLog(@"---------确定注册------");
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
            
            //判断格式是否正确
            if ([inputV.leftLabel.text isEqualToString:@"＊密码"]) {
                if (![Utils checkPassword:inputV.textField.text]) {
                    [Utils toastview:@"密码必须至少包含数字和字母，且不得少于六位"];
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
                if (![Utils isMobile:inputV.textField.text]) {
                    [Utils toastview:@"请输入正确手机号"];
                    return;
                }
            }
            if ([inputV.leftLabel.text isEqualToString:@"＊验证码"]) {
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
        
        for (int i = 0; i < 3; i++) {
            UIImageView *imageV = self.chooseImageView.imageViews[i];
            if (imageV.hidden == YES || !imageV.image) {
                [Utils toastview:@"请选择图片"];
                return;
            }
        }
        
        
        NSMutableArray *regArr = [NSMutableArray array];
        for (int i = 0; i < self.inputViews.count; i ++) {
            InputView *inputV = self.inputViews[i];
            if ([inputV.textField.text isEqualToString:@""]) {
                [regArr addObject:@"无"];
            }else{
                [regArr addObject:inputV.textField.text];
            }
        }
        
        for (int i = 0; i < 2; i++) {
            UIImageView *regImageV = self.chooseImageView.imageViews[i];
            
            [regArr addObject:[Utils imagechange:regImageV.image]];
            
//            [regArr addObject:[Utils imageToNSStringWithImage:regImageV.image]];
//            [regArr addObject:@"image"];
        }
        
        RegisterModel *regModel = [[RegisterModel alloc] initWithArray:regArr];

        [self endEditing:YES];
        
        //注册操作
        _registerCallBack(regModel);
        
        
    }else{
        //获取验证码
        InputView *inputView = self.inputViews[4];
        NSString *phone = inputView.textField.text;
        if ([Utils isMobile:phone]) {
            NSLog(@"---------获取验证码------");
        }else{
            [Utils toastview:@"请输入正确格式手机号"];
        }
    }
}

- (void)tapChannelNameInputViewAction:(UITapGestureRecognizer *)tap{
    if (self.channelNameInputView.textField.enabled == NO) {
        [Utils toastview:@"请选择渠道类型"];
    }
}

@end
