//
//  NormalOrderView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "NormalOrderDetailView.h"

@interface NormalOrderDetailView ()

@property (nonatomic) NSArray *titles;

@end

@implementation NormalOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = @[@"订单信息",@"资费信息",@"客户信息"];
        [self headView];
        [self lineView];
        [self moveView];
    }
    return self;
}

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc] init];
        [self addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        for (int i = 0; i < self.titles.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth/3.0)*i, 0, screenWidth/3.0, 40)];
            [button setTitle:self.titles[i] forState:UIControlStateNormal];
            [_headView addSubview:button];
            [button setTitleColor:[Utils colorRGB:@"#333333"] forState:UIControlStateNormal];
            [button setTitleColor:MainColor forState:UIControlStateSelected];
            button.tag = 1130+i;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                button.selected = YES;
            }
        }
    }
    return _headView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headView.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        _lineView.backgroundColor = COLOR_BACKGROUND;
    }
    return _lineView;
}

- (UIView *)moveView{
    if (_moveView == nil) {
        _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, screenWidth/3, 1)];
        [self addSubview:_moveView];
        _moveView.backgroundColor = MainColor;
    }
    return _moveView;
}

#pragma mark - Method
- (void)buttonClickedAction:(UIButton *)button{
    //1130  1131  1132
    NSInteger i = button.tag - 1130;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.moveView.frame;
        frame.origin.y = i*screenWidth/3.0;
        self.moveView.frame = frame;
    }];
}

@end
