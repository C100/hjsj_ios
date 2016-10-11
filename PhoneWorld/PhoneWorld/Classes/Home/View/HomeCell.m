//
//  HomeCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "HomeCell.h"

#define bottomY (self.height - (self.width - 40) - 26)/2

@implementation HomeCell

- (UIImageView *)imageV{
    if(_imageV == nil){
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
        CGFloat width = self.width - 40;
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomY);
            make.left.equalTo(20);
            make.right.equalTo(-20);
            make.height.equalTo(width);
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
            make.right.left.mas_equalTo(0);
            make.height.mas_equalTo(16);
            make.bottom.equalTo(-bottomY);
        }];
    }
    return _titleLb;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
