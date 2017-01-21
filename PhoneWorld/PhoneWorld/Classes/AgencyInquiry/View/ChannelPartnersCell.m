//
//  ChannelPartnersCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChannelPartnersCell.h"

@implementation ChannelPartnersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self numberLB];
        [self nameLB];
        [self channelNameLB];
    }
    return self;
}

- (void)setChannelModel:(ChannelModel *)channelModel{
    _channelModel = channelModel;
    self.numberLB.text = [NSString stringWithFormat:@"工号：%@",channelModel.orgCode];
    self.channelNameLB.text = [NSString stringWithFormat:@"渠道名称：%@",channelModel.name];
    self.nameLB.text = [NSString stringWithFormat:@"姓名：%@",channelModel.contact];
}

- (UILabel *)nameLB{
    if (_nameLB == nil) {
        _nameLB = [[UILabel alloc] init];
        [self addSubview:_nameLB];
        _nameLB.font = [UIFont systemFontOfSize:textfont12];
        _nameLB.textColor = [Utils colorRGB:@"#666666"];
        _nameLB.text = @"渠道名称：";
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-screenWidth/2);
            make.width.mas_equalTo((screenWidth-30)/2);
            make.height.mas_equalTo(16);
        }];
    }
    return _nameLB;
}

- (UILabel *)numberLB{
    if (_numberLB == nil) {
        _numberLB = [[UILabel alloc] init];
        [self addSubview:_numberLB];
        _numberLB.font = [UIFont systemFontOfSize:textfont12];
        _numberLB.textColor = [Utils colorRGB:@"#666666"];
        _numberLB.text = @"工号：";
        [_numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo((screenWidth-30)/2);
        }];
    }
    return _numberLB;
}

- (UILabel *)channelNameLB{
    if (_channelNameLB == nil) {
        _channelNameLB = [[UILabel alloc] init];
        [self addSubview:_channelNameLB];
        _channelNameLB.font = [UIFont systemFontOfSize:textfont12];
        _channelNameLB.textColor = [Utils colorRGB:@"#666666"];
        _channelNameLB.text = @"姓名：";
        [_channelNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLB.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(screenWidth-30);
        }];
    }
    return _channelNameLB;
}

@end
