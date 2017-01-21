//
//  OrderTableViewCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self nameLabel];
        [self phoneLabel];
        [self dateLabel];
        [self stateLabel];
    }
    return self;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
        _nameLabel.font = [UIFont systemFontOfSize:textfont12];
        _nameLabel.textColor = [Utils colorRGB:@"#666666"];
        _nameLabel.text = @"姓名：";
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(-screenWidth/2);
        }];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] init];
        [self addSubview:_phoneLabel];
        _phoneLabel.font = [UIFont systemFontOfSize:textfont12];
        _phoneLabel.textColor = [Utils colorRGB:@"#666666"];
        _phoneLabel.text = @"号码：";
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(screenWidth/2);
        }];
    }
    return _phoneLabel;
}

- (UILabel *)dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] init];
        [self addSubview:_dateLabel];
        _dateLabel.font = [UIFont systemFontOfSize:textfont12];
        _dateLabel.textColor = [Utils colorRGB:@"#666666"];
        _dateLabel.text = @"日期：";
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(screenWidth/2);
        }];
    }
    return _dateLabel;
}

- (UILabel *)stateLabel{
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
        [self addSubview:_stateLabel];
        _stateLabel.font = [UIFont systemFontOfSize:textfont12];
        _stateLabel.textColor = [Utils colorRGB:@"#666666"];
        _stateLabel.text = @"状态：";
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_equalTo(13);
            make.left.mas_equalTo(screenWidth/2);
            make.right.mas_equalTo(-10);
        }];
    }
    return _stateLabel;
}

@end
