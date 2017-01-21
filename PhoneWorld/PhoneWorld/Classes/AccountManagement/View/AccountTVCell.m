//
//  AccountTVCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AccountTVCell.h"

@implementation AccountTVCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self imageV];
        [self titleLB];
    }
    return self;
}

- (UIImageView *)imageV{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.height.width.mas_equalTo(30);
        }];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageV;
}

- (UILabel *)titleLB{
    if (_titleLB == nil) {
        _titleLB = [[UILabel alloc] init];
        [self addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageV.mas_right).mas_equalTo(8);
            make.centerY.mas_equalTo(0);
        }];
        _titleLB.font = [UIFont systemFontOfSize:textfont18];
        _titleLB.textColor = [Utils colorRGB:@"#333333"];
    }
    return _titleLB;
}

@end
