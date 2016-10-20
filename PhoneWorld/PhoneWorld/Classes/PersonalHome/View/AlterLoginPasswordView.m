//
//  AlterLoginPasswordView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AlterLoginPasswordView.h"
#import "InputView.h"

@interface AlterLoginPasswordView ()
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSMutableArray *inputViews;
@end

@implementation AlterLoginPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftTitles = @[@"原密码",@"新密码",@"确认密码"];
        self.backgroundColor = COLOR_BACKGROUND;
        self.inputViews = [NSMutableArray array];
        
        for (int i = 0; i < self.leftTitles.count; i ++) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
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
        _saveButton = [[UIButton alloc] init];
        [self addSubview:_saveButton];
        [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(160);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTitleColor:MainColor forState:UIControlStateNormal];
        _saveButton.layer.cornerRadius = 20;
        _saveButton.layer.borderColor = MainColor.CGColor;
        _saveButton.layer.borderWidth = 1;
        _saveButton.layer.masksToBounds = YES;
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
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
    InputView *iv0 = self.inputViews[0];//原密码
    InputView *iv1 = self.inputViews[1];//新密码
    InputView *iv2 = self.inputViews[2];//新密码
    //判断愿密码是否正确
    //判断新密码输入是否一致
    if ([iv1.textField.text isEqualToString:iv2.textField.text] && ![iv0.textField.text isEqualToString:@""]) {
        _AlterPasswordCallBack(button);
    }else{
        [Utils toastview:@"两次密码输入不一致"];
    }
}

@end
