//
//  CommisionCountView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/21.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CommisionCountView.h"
#import "InputView.h"
#import "CountView.h" 

@interface CommisionCountView ()

@property (nonatomic) InputView *inputView;
@property (nonatomic) CountView *countView;//金额
@property (nonatomic) CountView *countView2;//开户量

@end

@implementation CommisionCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(screenWidth, 800);
        self.bounces = NO;
        self.backgroundColor = COLOR_BACKGROUND;
        InputView *inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        [self addSubview:inputView];
        inputView.leftLabel.text = @"佣金：2000元";
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
        _countView = [[CountView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 330) andTitle:@"金额"];
        [self addSubview:_countView];
    }
    return _countView;
}

- (CountView *)countView2{
    if (_countView2 == nil) {
        _countView2 = [[CountView alloc] initWithFrame:CGRectMake(0, 390, screenWidth, 330) andTitle:@"开户量"];
        [self addSubview:_countView2];
    }
    return _countView2;
}

@end
