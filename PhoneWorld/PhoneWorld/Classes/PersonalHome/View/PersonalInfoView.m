//
//  PersonalInfoView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PersonalInfoView.h"
#import "InputView.h"
#import "FailedView.h"

@interface PersonalInfoView ()
@property (nonatomic) NSMutableArray *leftTitles;
@property (nonatomic) FailedView *resultView;
@property (nonatomic) NSInteger ivNumber;
@end

@implementation PersonalInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        
        self.leftTitles = [@[@"用户名",@"姓名",@"手机号码",@"电子邮箱",@"渠道名称",@"上级名称",@"上级电话"] mutableCopy];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *grade = [ud objectForKey:@"grade"];
        
        NSLog(@"-----------%@------------",grade);
        
        if ([grade isEqualToString:@"lev3"]) {
            [self.leftTitles addObject:@"上级推荐码"];
        }
        if ([grade isEqualToString:@"lev2"]) {
            [self.leftTitles addObjectsFromArray:@[@"本人推荐码",@"上级推荐码"]];
        }
        if ([grade isEqualToString:@"lev1"]) {
            [self.leftTitles addObject:@"本人推荐码"];
        }
        
        self.inputViews = [NSMutableArray array];
        self.bounces = NO;
        for (int i = 0; i < self.leftTitles.count; i ++) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.text = @"";
            view.textField.placeholder = self.leftTitles[i];
            [view addGestureRecognizer:tap];
            view.tag = 100+i;
            [self.inputViews addObject:view];
            [self addSubview:view];
            view.textField.userInteractionEnabled = NO;
            if ([self.leftTitles[i] isEqualToString:@"电子邮箱"]) {
                view.textField.userInteractionEnabled = YES;
                view.textField.text = @"";
                view.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
            }
        }
        [self saveButton];
        
        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40*self.leftTitles.count)];
        leftV.backgroundColor = [UIColor whiteColor];
        [self addSubview:leftV];
    }
    return self;
}

- (void)setPersonModel:(PersonalInfoModel *)personModel{
    for (InputView *inputV in self.inputViews) {
        
        //@"用户名",@"姓名",@"手机号码",@"电子邮箱",@"渠道名称",@"上级名称",@"上级电话",@"上级推荐码",@"本人推荐码"
        
        if ([inputV.leftLabel.text isEqualToString:@"用户名"]) {
            inputV.textField.text = personModel.username;
        }
        if ([inputV.leftLabel.text isEqualToString:@"姓名"]) {
            inputV.textField.text = personModel.contact;
        }
        if ([inputV.leftLabel.text isEqualToString:@"手机号码"]) {
            inputV.textField.text = personModel.tel;
        }
        if ([inputV.leftLabel.text isEqualToString:@"电子邮箱"]) {
            inputV.textField.text = personModel.email;
        }
        if ([inputV.leftLabel.text isEqualToString:@"渠道名称"]) {
            inputV.textField.text = personModel.channelName;
        }
        if ([inputV.leftLabel.text isEqualToString:@"上级名称"]) {
            inputV.textField.text = personModel.supUserName;
        }
        if ([inputV.leftLabel.text isEqualToString:@"上级电话"]) {
            inputV.textField.text = personModel.supTel;
        }
        if ([inputV.leftLabel.text isEqualToString:@"上级推荐码"]) {
            inputV.textField.text = personModel.supRecomdCode;
        }
        if ([inputV.leftLabel.text isEqualToString:@"本人推荐码"]) {
            inputV.textField.text = personModel.recomdCode;
        }
        
    }
}

- (UIButton *)saveButton{
    if (_saveButton == nil) {
        _saveButton = [Utils returnBextButtonWithTitle:@"保存"];
        [self addSubview:_saveButton];
        InputView *inputV = self.inputViews.lastObject;
        [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(inputV.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_saveButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

#pragma mark - Method
- (void)tapAction:(UITapGestureRecognizer *)tap{
    InputView *view = (InputView *)tap.view;
    [view.textField becomeFirstResponder];
}

- (void)buttonClickAction:(UIButton *)button{
    for (int i = 0; i < self.inputViews.count; i++) {
        InputView *inputV = self.inputViews[i];
        if ([inputV.leftLabel.text isEqualToString:@"联系号码"] && ![inputV.textField.text isEqualToString:@""]) {
            if (![Utils isMobile:inputV.textField.text]) {
                [Utils toastview:@"请输入正确联系号码"];
                return;
            }
        }
        if ([inputV.leftLabel.text isEqualToString:@"电子邮箱"] && ![inputV.textField.text isEqualToString:@""]) {
            if (![Utils isMobile:inputV.textField.text]) {
                [Utils toastview:@"请输入正确电子邮箱"];
                return;
            }
        }
        if ([inputV.leftLabel.text isEqualToString:@"上级电话"] && ![inputV.textField.text isEqualToString:@""]) {
            if (![Utils isMobile:inputV.textField.text]) {
                [Utils toastview:@"请输入正确上级电话号码"];
                return;
            }
        }
    }
    //个人信息保存
    self.resultView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"保存成功" andDetail:@"正在跳转..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
    [[UIApplication sharedApplication].keyWindow addSubview:self.resultView];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissResultViewAction) userInfo:nil repeats:NO];
}

- (void)dismissResultViewAction{
    [UIView animateWithDuration:0.5 animations:^{
        self.resultView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.resultView removeFromSuperview];
        UIViewController *viewController = [self viewController];
        [viewController.navigationController popViewControllerAnimated:YES];
    }];
}

@end
