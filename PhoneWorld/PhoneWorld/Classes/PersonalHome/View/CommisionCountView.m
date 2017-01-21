//
//  CommisionCountView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/21.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CommisionCountView.h"

#define hw 312.0/375.0

@interface CommisionCountView ()

@end

@implementation CommisionCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentSize = CGSizeMake(screenWidth, 800);
        self.bounces = NO;
        self.backgroundColor = COLOR_BACKGROUND;
        InputView *inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        [self addSubview:inputView];
        inputView.leftLabel.text = @"佣金：0元";
        inputView.textField.placeholder = @"2016.09-2016.10";
        inputView.textField.userInteractionEnabled = NO;
        [inputView.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(110);
        }];
        self.inputView = inputView;
        
        [self countView];
        [self countView2];

    }
    return self;
}

- (CountView *)countView{
    if (_countView == nil) {
        _countView = [[CountView alloc] initWithFrame:CGRectZero andTitle:@"金额"];
        [self addSubview:_countView];
        [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.top.mas_equalTo(self.inputView.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(screenWidth*hw + 40);
        }];
    }
    return _countView;
}

- (CountView *)countView2{
    if (_countView2 == nil) {
        _countView2 = [[CountView alloc] initWithFrame:CGRectZero andTitle:@"开户量"];
        [self addSubview:_countView2];
        [_countView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.countView.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(screenWidth*hw + 40);
            make.width.mas_equalTo(screenWidth);
            make.bottom.mas_equalTo(-75);
        }];
    }
    return _countView2;
}

@end
