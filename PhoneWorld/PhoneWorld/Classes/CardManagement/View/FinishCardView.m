//
//  FinishCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "FinishCardView.h"
#import "FailedView.h"
#import "ChoosePackageViewController.h"

@interface FinishCardView ()

@property (nonatomic) FailedView *failedView;

@end

@implementation FinishCardView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        [self phoneView];
        [self pukView];
        [self nextButton];
    }
    return self;
}

- (UIView *)phoneView{
    if (_phoneView == nil) {
        _phoneView = [[UIView alloc] init];
        _phoneView.tag = 111;
        [self addSubview:_phoneView];
        [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(1);
            make.height.mas_equalTo(40);
        }];
        _phoneView.backgroundColor = [UIColor whiteColor];
        
        UILabel *leftLB = [[UILabel alloc] init];
        [_phoneView addSubview:leftLB];
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        leftLB.text = @"手机号码";
        leftLB.textColor = [Utils colorRGB:@"#666666"];
        leftLB.font = [UIFont systemFontOfSize:14];
        
        UILabel *rightLB = [[UILabel alloc] init];
        [_phoneView addSubview:rightLB];
        [rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(leftLB.mas_right).mas_equalTo(0);
        }];
        rightLB.textAlignment = NSTextAlignmentRight;
        rightLB.text = @"请输入手机号码";
        rightLB.textColor = [Utils colorRGB:@"#cccccc"];
        rightLB.font = [UIFont systemFontOfSize:12];
        self.phoneLB = rightLB;
        
        UITextField *tf = [[UITextField alloc] init];
        tf.tag = 1000;
        [_phoneView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(leftLB.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(30);
        }];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.hidden = YES;
        tf.textColor = [Utils colorRGB:@"#666666"];
        tf.font = [UIFont systemFontOfSize:14];
        [tf setReturnKeyType:UIReturnKeyDone];
        tf.delegate = self;
        [tf addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        self.phoneTF = tf;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_phoneView addGestureRecognizer:tap];
    }
    return _phoneView;
}

- (UIView *)pukView{
    if (_pukView == nil) {
        _pukView = [[UIView alloc] init];
        _pukView.tag = 222;
        [self addSubview:_pukView];
        [_pukView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.phoneView.mas_bottom).mas_equalTo(1);
            make.height.mas_equalTo(40);
        }];
        _pukView.backgroundColor = [UIColor whiteColor];
        
        UILabel *leftLB = [[UILabel alloc] init];
        [_pukView addSubview:leftLB];
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        leftLB.text = @"PUK码";
        leftLB.textColor = [Utils colorRGB:@"#666666"];
        leftLB.font = [UIFont systemFontOfSize:14];
        
        UILabel *rightLB = [[UILabel alloc] init];
        [_pukView addSubview:rightLB];
        [rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(leftLB.mas_right).mas_equalTo(0);
        }];
        rightLB.textAlignment = NSTextAlignmentRight;
        rightLB.text = @"请输入PUK码";
        rightLB.textColor = [Utils colorRGB:@"#cccccc"];
        rightLB.font = [UIFont systemFontOfSize:12];
        self.pukLB = rightLB;
        
        UITextField *tf = [[UITextField alloc] init];
        [_pukView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(leftLB.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(30);
        }];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.hidden = YES;
        tf.textColor = [Utils colorRGB:@"#666666"];
        tf.font = [UIFont systemFontOfSize:14];
        tf.tag = 2000;
        [tf setReturnKeyType:UIReturnKeyDone];
        tf.delegate = self;
        [tf addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        self.pukTF = tf;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_pukView addGestureRecognizer:tap];
    }
    return _pukView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pukView.mas_bottom).mas_equalTo(40);
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
- (void)textFieldDidChanged:(UITextField *)textField{
    if (textField.tag == 1000) {
        //phone
        self.phoneLB.text = textField.text;
        self.phoneLB.textColor = [Utils colorRGB:@"#666666"];
    }else if(textField.tag == 2000){
        //puk
        self.pukLB.text = textField.text;
        self.pukLB.textColor = [Utils colorRGB:@"#666666"];
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![Utils isMobile:self.phoneTF.text]) {
        self.phoneLB.text = @"请输入手机号码";
        [Utils toastview:@"请输入正确格式手机号"];
    }
    if(![Utils isNumber:self.pukTF.text]){
        self.pukLB.text = @"请输入PUK码";
        [Utils toastview:@"请输入数字"];
    }
    self.phoneTF.hidden = YES;
    self.pukTF.hidden = YES;
    return YES;
}

#pragma mark - Method

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 222) {//puk
        self.pukTF.hidden = self.pukTF.hidden == NO ? YES : NO;
        self.phoneTF.hidden = YES;
        [self.pukTF becomeFirstResponder];
    }else{
        self.phoneTF.hidden = self.phoneTF.hidden == NO ? YES : NO;
        self.pukTF.hidden = YES;
        [self.phoneTF becomeFirstResponder];
    }
}

- (void)buttonClickAction:(UIButton *)button{
    //下一步
    [self endEditing:YES];
    if ([Utils isMobile:self.phoneTF.text] && [Utils isNumber:self.pukTF.text]) {
        //检测
        //成功
        ChoosePackageViewController *vc = [ChoosePackageViewController new];
        vc.userinfosDic = [@{@"phoneNumber":self.phoneTF.text,@"phoneAddress":@"浙江省杭州市",@"phoneState":@"已激活",@"networkType":@"话机通信"} mutableCopy];
        UIViewController *viewController = [self viewController];
        [viewController.navigationController pushViewController:vc animated:YES];
        
        //失败
//        self.failedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"验证失败" andDetail:@"手机号码或PUK码错误" andImageName:@"attention"];
//        [[UIApplication sharedApplication].keyWindow addSubview:self.failedView];
//        
//        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeGrayView) userInfo:nil repeats:NO];
    }else{
        if (![Utils isMobile:self.phoneTF.text]) {
            [Utils toastview:@"请输入正确格式手机号"];
        }else if(![Utils isNumber:self.pukTF.text]){
            [Utils toastview:@"请输入正确格式PUK码"];
        }
    }
}

- (void)removeGrayView{
    [UIView animateWithDuration:1.0 animations:^{
        self.failedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.failedView removeFromSuperview];
    }];
}

@end
