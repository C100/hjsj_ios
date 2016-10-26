//
//  WhiteCardCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "WhiteCardCell.h"
#import "PhoneDetailView.h"

@implementation WhiteCardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self leftButton];
        [self rightButton];
        [self phoneLB];
    }
    return self;
}

- (UIButton *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [[UIButton alloc] init];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.height.mas_equalTo(10);
        }];
        _leftButton.backgroundColor = [Utils colorRGB:@"#ffffff"];
        _leftButton.layer.borderColor = [Utils colorRGB:@"#cccccc"].CGColor;
        _leftButton.layer.borderWidth = 1;
        _leftButton.layer.cornerRadius = 5;
        _leftButton.layer.masksToBounds = YES;
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc] init];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.width.height.mas_equalTo(18);
        }];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"detail"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        [self addSubview:_phoneLB];
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.leftButton.mas_right).mas_equalTo(5);
            make.right.mas_equalTo(self.rightButton.mas_right).mas_equalTo(-10);
        }];
        _phoneLB.font = [UIFont systemFontOfSize:14];
        _phoneLB.textColor = [Utils colorRGB:@"#666666"];
    }
    return _phoneLB;
}

#pragma mark - Method
- (void)detailAction:(UIButton *)button{
    PhoneDetailView *detailView = [[PhoneDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andPhoneInfo:@[@"AAA",@"300元",@"79.9元套餐起周期12月"]];
    [[UIApplication sharedApplication].keyWindow addSubview:detailView];
}

@end
