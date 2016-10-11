//
//  DropDownView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "DropDownView.h"

@implementation DropDownView

- (UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"日历"];
        _rightImageView.size = CGSizeMake(12, 6);
        _rightImageView.contentMode = UIViewContentModeCenter;
    }
    return _rightImageView;
}

- (UILabel *)timeLB{
    if (_timeLB == nil) {
        [self addSubview:_timeLB];
        _timeLB.font = [UIFont systemFontOfSize:14];
        _timeLB.textColor = TextColor;
        _timeLB.text = @"订单时间：";
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(45);
            make.top.equalTo(25);
            make.height.equalTo(16);
            make.width.equalTo(70);
        }];
    }
    return _timeLB;
}

- (UITextField *)beginTime{
    if (_beginTime == nil) {
        [self addSubview:_beginTime];
        
        [_beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLB.mas_right).equalTo(0);
            make.top.equalTo(25);
            make.height.equalTo(28);
            make.right.equalTo(self.v.mas_left).equalTo(-4);
        }];
        _beginTime.rightViewMode = UITextFieldViewModeAlways;
        _beginTime.rightView = self.rightImageView;
    }
    return _beginTime;
}

- (UIView *)v{
    if (_v == nil) {
        [self addSubview:_v];
        _v.backgroundColor = COLOR_BACKGROUND;
        [_v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.beginTime.right).equalTo(4);
            make.right.equalTo(self.endTime.left).equalTo(-4);
            make.top.equalTo(38);
            make.width.equalTo(6);
            make.height.equalTo(1);
        }];
    }
    return _v;
}

- (UITextField *)endTime{
    if (_endTime == nil) {
        [self addSubview:_endTime];
        [_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(45);
            make.top.equalTo(25);
            make.height.equalTo(28);
            make.left.equalTo(self.v.mas_right).equalTo(4);
        }];
        _endTime.rightViewMode = UITextFieldViewModeAlways;
        _endTime.rightView = self.rightImageView;
    }
    return _endTime;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
