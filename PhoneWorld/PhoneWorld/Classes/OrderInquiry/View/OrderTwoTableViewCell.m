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
        [self phoneLB];
        [self moneyLB];
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
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(18);
        }];
    }
    return _numberLB;
}

- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        [self addSubview:_phoneLB];
        _phoneLB.font = [UIFont systemFontOfSize:textfont12];
        _phoneLB.textColor = [Utils colorRGB:@"#666666"];
        _phoneLB.text = @"号码：";
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.numberLB.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(screenWidth/2 - 10);
            make.height.mas_equalTo(18);
        }];
    }
    return _phoneLB;
}

- (UILabel *)moneyLB{
    if (_moneyLB == nil) {
        _moneyLB = [[UILabel alloc] init];
        [self addSubview:_moneyLB];
        _moneyLB.font = [UIFont systemFontOfSize:textfont12];
        _moneyLB.textColor = [Utils colorRGB:@"#666666"];
        _moneyLB.text = @"金额：";
        [_moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.numberLB.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo((screenWidth-20)/2);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(18);
        }];
    }
    return _moneyLB;
}

- (UILabel *)dateLB{
    if (_dateLB == nil) {
        _dateLB = [[UILabel alloc] init];
        [self addSubview:_dateLB];
        _dateLB.font = [UIFont systemFontOfSize:textfont12];
        _dateLB.textColor = [Utils colorRGB:@"#666666"];
        _dateLB.text = @"日期：";
        [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneLB.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth/2 - 10);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(10);
        }];
    }
    return _dateLB;
}

- (UILabel *)stateLB{
    if (_stateLB == nil) {
        _stateLB = [[UILabel alloc] init];
        [self addSubview:_stateLB];
        _stateLB.font = [UIFont systemFontOfSize:textfont12];
        _stateLB.textColor = [Utils colorRGB:@"#666666"];
        _stateLB.text = @"状态：";
        [_stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.moneyLB.mas_bottom).mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo((screenWidth - 20)/2);
            make.height.mas_equalTo(18);
        }];
    }
    return _stateLB;
}

- (void)setRechargeModel:(RechargeListModel *)rechargeModel{
    _rechargeModel = rechargeModel;
    
    self.numberLB.text = [NSString stringWithFormat:@"编号：%@",rechargeModel.orderNo];
    
    NSString *dateString = [rechargeModel.rechargeDate componentsSeparatedByString:@" "].firstObject;
    self.dateLB.text = [NSString stringWithFormat:@"日期：%@",dateString];

    self.moneyLB.text = [NSString stringWithFormat:@"金额：%@",rechargeModel.payAmount];
    self.phoneLB.text = [NSString stringWithFormat:@"号码：%@",rechargeModel.number];
    self.stateLB.text = [NSString stringWithFormat:@"状态：%@",rechargeModel.startName];
    
}

@end
