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
        [self dateLB];
    }
    return self;
}

- (UILabel *)nameLB{
    if (_nameLB == nil) {
        _nameLB = [[UILabel alloc] init];
        [self addSubview:_nameLB];
        _nameLB.font = [UIFont systemFontOfSize:13];
        _nameLB.textColor = [Utils colorRGB:@"#666666"];
        _nameLB.text = @"姓名：话机世界";
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
        _numberLB.font = [UIFont systemFontOfSize:13];
        _numberLB.textColor = [Utils colorRGB:@"#666666"];
        _numberLB.text = @"号码：18812341234";
        [_numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo((screenWidth-30)/2);
        }];
    }
    return _numberLB;
}

- (UILabel *)dateLB{
    if (_dateLB == nil) {
        _dateLB = [[UILabel alloc] init];
        [self addSubview:_dateLB];
        _dateLB.font = [UIFont systemFontOfSize:13];
        _dateLB.textColor = [Utils colorRGB:@"#666666"];
        _dateLB.text = @"渠道名称：高度需计算";
        [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLB.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(screenWidth-30);
        }];
    }
    return _dateLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
