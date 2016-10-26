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
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) FailedView *resultView;
@end

@implementation PersonalInfoView

- (instancetype)initWithFrame:(CGRect)frame andUserinfos:(NSMutableArray *)userinfos
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.userinfos = userinfos;
        self.leftTitles = @[@"用户名",@"联系人",@"联系号码",@"电子邮箱",@"渠道名称",@"上级名称",@"上级电话",@"上级推荐码",@"本人推荐码"];
        self.inputViews = [NSMutableArray array];
        self.bounces = NO;
        for (int i = 0; i < self.leftTitles.count; i ++) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.text = self.leftTitles[i];
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
    }
    return self;
}

- (UIButton *)saveButton{
    if (_saveButton == nil) {
        _saveButton = [Utils returnBextButtonWithTitle:@"保存"];
        [self addSubview:_saveButton];
        [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(400);
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
