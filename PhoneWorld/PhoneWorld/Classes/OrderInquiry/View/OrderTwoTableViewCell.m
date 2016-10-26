//
//  OrderTwoTableViewCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderTwoTableViewCell.h"

@implementation OrderTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self numberLB];
        [self dateLB];
        [self typeLB];
        [self moneyLB];
        [self phoneLB];
        [self stateLB];
    }
    return self;
}

- (UILabel *)numberLB{
    if (_numberLB == nil) {
        _numberLB = [[UILabel alloc] init];
        [self addSubview:_numberLB];
        _numberLB.font = [UIFont systemFontOfSize:textfont12];
        _numberLB.textColor = [Utils colorRGB:@"#666666"];
        _numberLB.text = @"编号：";
        [_numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.right.mas_equalTo(-screenWidth/2);
        }];
    }
    return _numberLB;
}

- (UILabel *)dateLB{
    if (_dateLB == nil) {
        _dateLB = [[UILabel alloc] init];
        [self addSubview:_dateLB];
        _dateLB.font = [UIFont systemFontOfSize:textfont12];
        _dateLB.textColor = [Utils colorRGB:@"#666666"];
        _dateLB.text = @"日期：";
        [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(screenWidth/2);
        }];
    }
    return _dateLB;
}

- (UILabel *)typeLB{
    if (_typeLB == nil) {
        _typeLB = [[UILabel alloc] init];
        [self addSubview:_typeLB];
        _typeLB.font = [UIFont systemFontOfSize:textfont12];
        _typeLB.textColor = [Utils colorRGB:@"#666666"];
        _typeLB.text = @"类型：话费充值";
        [_typeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.numberLB.mas_bottom).mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(screenWidth/2);
        }];
    }
    return _typeLB;
}

- (UILabel *)moneyLB{
    if (_moneyLB == nil) {
        _moneyLB = [[UILabel alloc] init];
        [self addSubview:_moneyLB];
        _moneyLB.font = [UIFont systemFontOfSize:textfont12];
        _moneyLB.textColor = [Utils colorRGB:@"#666666"];
        _moneyLB.text = @"金额：";
        [_moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.dateLB.mas_bottom).mas_equalTo(13);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(screenWidth/2);
        }];
    }
    return _moneyLB;
}

- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        [self addSubview:_phoneLB];
        _phoneLB.font = [UIFont systemFontOfSize:12];
        _phoneLB.textColor = [Utils colorRGB:@"#666666"];
        _phoneLB.text = @"号码：00000000000";
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.typeLB.mas_bottom).mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(screenWidth/2);
        }];
    }
    return _phoneLB;
}

- (UILabel *)stateLB{
    if (_stateLB == nil) {
        _stateLB = [[UILabel alloc] init];
        [self addSubview:_stateLB];
        _stateLB.font = [UIFont systemFontOfSize:textfont12];
        _stateLB.textColor = [Utils colorRGB:@"#666666"];
        _stateLB.text = @"状态：";
        [_stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.moneyLB.mas_bottom).mas_equalTo(13);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(screenWidth/2);
        }];
    }
    return _stateLB;
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
