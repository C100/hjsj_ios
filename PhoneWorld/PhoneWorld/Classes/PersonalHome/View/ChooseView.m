//
//  ChooseView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/21.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChooseView.h"

@interface ChooseView ()

@property (nonatomic) NSString *title;

@end

@implementation ChooseView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        [self leftView];
        [self titleLB];
    }
    return self;
}

- (UIView *)leftView{
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        [self addSubview:_leftView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(10);
        }];
        _leftView.layer.cornerRadius = 5;
        _leftView.layer.borderColor = [Utils colorRGB:@"#cccccc"].CGColor;
        _leftView.layer.borderWidth = 1;
        _leftView.layer.masksToBounds = YES;
    }
    return _leftView;
}

- (UILabel *)titleLB{
    if (_titleLB == nil) {
        _titleLB = [[UILabel alloc] init];
        [self addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(self.leftView.mas_right).mas_equalTo(6);
        }];
        _titleLB.font = [UIFont systemFontOfSize:textfont14];
        _titleLB.textColor = [Utils colorRGB:@"#666666"];
        _titleLB.text = self.title;
    }
    return _titleLB;
}

@end
