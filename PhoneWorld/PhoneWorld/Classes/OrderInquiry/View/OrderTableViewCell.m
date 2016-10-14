//
//  OrderTableViewCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (UILabel *)numberLB{
    if (_numberLB == nil) {
        _numberLB = [[UILabel alloc] init];
        [self addSubview:_numberLB];
        _numberLB.font = [UIFont systemFontOfSize:12];
        _numberLB.textColor = [Utils colorRGB:@"#333333"];
        _numberLB.text = @"编号：";
        [_numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(-screenWidth/2);
        }];
    }
    return _numberLB;
}

- (UILabel *)nameLB{
    if (_nameLB == nil) {
        _nameLB = [[UILabel alloc] init];
        [self addSubview:_nameLB];
        _nameLB.font = [UIFont systemFontOfSize:12];
        _nameLB.textColor = [Utils colorRGB:@"#333333"];
        _nameLB.text = @"姓名：";
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.numberLB.mas_bottom).mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(screenWidth/2);
        }];
    }
    return _nameLB;
}

- (UILabel *)dateLB{
    if (_dateLB == nil) {
        _dateLB = [[UILabel alloc] init];
        [self addSubview:_dateLB];
        _dateLB.font = [UIFont systemFontOfSize:12];
        _dateLB.textColor = [Utils colorRGB:@"#333333"];
        _dateLB.text = @"日期：";
        [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(screenWidth/2);
        }];
    }
    return _dateLB;
}

- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        [self addSubview:_phoneLB];
        _phoneLB.font = [UIFont systemFontOfSize:12];
        _phoneLB.textColor = [Utils colorRGB:@"#333333"];
        _phoneLB.text = @"手机号码：";
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.dateLB.mas_bottom).mas_equalTo(13);
            make.left.mas_equalTo(screenWidth/2);
            make.right.mas_equalTo(-10);
        }];
    }
    return _phoneLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
