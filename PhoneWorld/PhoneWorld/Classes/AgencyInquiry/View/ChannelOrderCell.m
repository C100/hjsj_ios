//
//  ChannelOrderCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChannelOrderCell.h"

@implementation ChannelOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self nameLB];
        [self phoneLB];
        [self numberLB];
        [self wayLB];
    }
    return self;
}

- (void)setOrderCountModel:(OrderCountModel *)orderCountModel{
    _orderCountModel = orderCountModel;
    self.nameLB.text = [NSString stringWithFormat:@"姓名：%@",orderCountModel.contact];
    self.phoneLB.text = [NSString stringWithFormat:@"工号：%@",orderCountModel.orgCode];
    self.numberLB.text = [NSString stringWithFormat:@"开户量：%d",orderCountModel.openCount];
    self.wayLB.text = [NSString stringWithFormat:@"渠道名称：%@",orderCountModel.name];
}

- (UILabel *)nameLB{
    if (_nameLB == nil) {
        _nameLB = [[UILabel alloc] init];
        [self addSubview:_nameLB];
        _nameLB.font = [UIFont systemFontOfSize:textfont12];
        _nameLB.textColor = [Utils colorRGB:@"#666666"];
        _nameLB.text = @"姓名：话机世界";
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo((screenWidth-30)/2);
            make.height.mas_equalTo(16);
        }];
    }
    return _nameLB;
}

- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        [self addSubview:_phoneLB];
        _phoneLB.font = [UIFont systemFontOfSize:textfont12];
        _phoneLB.textColor = [Utils colorRGB:@"#666666"];
        _phoneLB.text = @"工号：";
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
            make.width.mas_equalTo((screenWidth-30)/2);
        }];
    }
    return _phoneLB;
}

- (UILabel *)numberLB{
    if (_numberLB == nil) {
        _numberLB = [[UILabel alloc] init];
        [self addSubview:_numberLB];
        _numberLB.font = [UIFont systemFontOfSize:textfont12];
        _numberLB.textColor = [Utils colorRGB:@"#666666"];
        _numberLB.text = @"开户总量：10000";
        [_numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLB.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo((screenWidth-30)/2);
        }];
    }
    return _numberLB;
}

- (UILabel *)wayLB{
    if (_wayLB == nil) {
        _wayLB = [[UILabel alloc] init];
        [self addSubview:_wayLB];
        _wayLB.font = [UIFont systemFontOfSize:textfont12];
        _wayLB.textColor = [Utils colorRGB:@"#666666"];
        _wayLB.text = @"渠道名称：高度需计算";
        [_wayLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.numberLB.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(screenWidth-30);
            make.bottom.mas_equalTo(-10);
        }];
    }
    return _wayLB;
}

@end
