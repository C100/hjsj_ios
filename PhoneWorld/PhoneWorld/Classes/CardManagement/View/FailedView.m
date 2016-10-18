//
//  FailedView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "FailedView.h"

@implementation FailedView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.4;
        [self stateView];
    }
    return self;
}

- (UIView *)stateView{
    _stateView = [[UIView alloc] init];
    [self addSubview:_stateView];
    [_stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(90);
    }];
    _stateView.backgroundColor = [UIColor whiteColor];
    _stateView.layer.cornerRadius = 10;
    _stateView.layer.masksToBounds = YES;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [_stateView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(87);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(24);
    }];
    imageV.image = [UIImage imageNamed:@"attention"];
    imageV.contentMode = UIViewContentModeScaleToFill;
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"验证失败";
    [_stateView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV.mas_right).mas_equalTo(8);
        make.top.mas_equalTo(23);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(18);
    }];
    lb.font = [UIFont systemFontOfSize:16];
    lb.textColor = [Utils colorRGB:@"#333333"];
    
    UILabel *lb2 = [[UILabel alloc] init];
    lb2.text = @"手机号码或者PUK码错误";
    [_stateView addSubview:lb2];
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(67);
        make.bottom.mas_equalTo(-23);
        make.right.mas_equalTo(-67);
        make.height.mas_equalTo(14);
    }];
    lb2.font = [UIFont systemFontOfSize:12];
    lb2.textColor = [Utils colorRGB:@"#333333"];
    
    return _stateView;
}

@end
