//
//  CreatePayPasswordView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CreatePayPasswordView.h"
#import "InputView.h"
#import "PersonalHomeViewController.h"

@interface CreatePayPasswordView ()

@property (nonatomic) NSArray *leftTitles;

@end

@implementation CreatePayPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"密码",@"确认密码"];
        self.inputViews = [NSMutableArray array];
        for (int i = 0; i < self.leftTitles.count; i ++) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            if (i == 0) {
                view.textField.placeholder = [NSString stringWithFormat:@"请输入6位数字密码"];
            }else{
                view.textField.placeholder = [NSString stringWithFormat:@"请再次输入密码"];
            }
            [view addGestureRecognizer:tap];
            view.tag = 100+i;
            [self.inputViews addObject:view];
            [self addSubview:view];
        }
        [self saveButton];
    }
    return self;
}

- (UIButton *)saveButton{
    if (_saveButton == nil) {
        _saveButton = [Utils returnNextButtonWithTitle:@"确定"];
        [self addSubview:_saveButton];
        [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(120);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

#pragma mark - Method
- (void)tapAction:(UITapGestureRecognizer *)tap{
    InputView *view = (InputView *)tap.view;
    [view.textField becomeFirstResponder];
}

- (void)saveAction:(UIButton *)button{
    InputView *iv0 = self.inputViews[0];
    InputView *iv1 = self.inputViews[1];
    if ([iv0.textField.text isEqualToString:iv1.textField.text] && ![iv0.textField.text isEqualToString:@""]) {
        [self endEditing:YES];
        _CreatePayPasswordCallBack(button);
    }else{
        [Utils toastview:@"两次密码输入不一致"];
    }
}

@end
