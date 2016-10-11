//
//  HomeCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (UIImageView *)imageV{
    if(_imageV == nil){
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(80);
            make.width.equalTo(80);
            make.centerX.equalTo(0);
            make.bottom.equalTo(-51);
        }];
    }
    return _imageV;
}

- (UILabel *)titleLb{
    if (_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self addSubview:_titleLb];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textColor = TextColor;
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageV.mas_bottom).with.offset(0);
            make.right.left.mas_equalTo(0);
            make.height.mas_equalTo(16);
            make.bottom.equalTo(-25);
        }];
    }
    return _titleLb;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
