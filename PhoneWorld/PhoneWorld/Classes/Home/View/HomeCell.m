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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self imageV];
        [self titleLb];
    }
    return self;
}

- (UIImageView *)imageV{
    if(_imageV == nil){
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
        CGFloat width = self.width - 40;
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomY);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(width);
        }];
    }
    return _imageV;
}

- (UILabel *)titleLb{
    if (_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self addSubview:_titleLb];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.font = [UIFont systemFontOfSize:textfont16];
        _titleLb.textColor = [Utils colorRGB:@"#666666"];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.height.mas_equalTo(16);
            make.bottom.mas_equalTo(-bottomY);
        }];
    }
    return _titleLb;
}


@end
