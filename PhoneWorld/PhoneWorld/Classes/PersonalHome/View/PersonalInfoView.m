//
//  PersonalInfoView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PersonalInfoView.h"
#import "InputView.h"

@interface PersonalInfoView ()
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSMutableArray *inputViews;
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
            view.rightLabel.text = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
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
            make.top.mas_equalTo(400);
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
        [_saveButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

#pragma mark - Method
- (void)tapAction:(UITapGestureRecognizer *)tap{
    for (InputView *iv in self.inputViews) {
        iv.textField.hidden = YES;
    }
    InputView *view = (InputView *)tap.view;
    view.textField.hidden = NO;
    [view.textField becomeFirstResponder];
}

- (void)buttonClickAction:(UIButton *)button{
    //个人信息保存
    _PersonalInfoCallBack(button);
}

@end
