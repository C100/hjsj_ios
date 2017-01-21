//
//  SettingTableViewCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self titleLabel];
        [self rightImageView];
        [self detailLabel];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(20);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(150);
        }];
        _titleLabel.textColor = [Utils colorRGB:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:textfont16];
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        [self addSubview:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(16);
        }];
        _rightImageView.image = [UIImage imageNamed:@"right"];
    }
    return _rightImageView;
}

- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        [self addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(self.rightImageView.mas_left).mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(150);
        }];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.textColor = [Utils colorRGB:@"#999999"];
        _detailLabel.font = [UIFont systemFontOfSize:textfont14];
    }
    return _detailLabel;
}

@end
