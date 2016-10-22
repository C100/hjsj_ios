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
@property (nonatomic) CountView *countView;

@end

@implementation CommisionCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    }
    return self;
}

- (CountView *)countView{
    if (_countView == nil) {
        _countView = [[CountView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 312)];
        [self addSubview:_countView];
    }
    return _countView;
}

@end
