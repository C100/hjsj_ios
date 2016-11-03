
//
//  MessageTCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MessageTCell.h"

@implementation MessageTCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self headIV];
        [self nameLB];
        [self detailLB];
    }
    return self;
}

- (UIImageView *)headIV{
    if (_headIV == nil) {
        _headIV = [[UIImageView alloc] init];
        [self addSubview:_headIV];
        [_headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.width.height.mas_equalTo(40);
        }];
//        _headIV.image = [_headIV.image cutCircleImage];
        _headIV.layer.cornerRadius = 20;
        _headIV.layer.masksToBounds = YES;
    }
    return _headIV;
}

- (UILabel *)nameLB{
    if (_nameLB == nil) {
        _nameLB = [[UILabel alloc] init];
        [self addSubview:_nameLB];
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headIV.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(-15);
        }];
        _nameLB.font = [UIFont systemFontOfSize:14];
        _nameLB.textColor = [Utils colorRGB:@"#666666"];
    }
    return _nameLB;
}

- (UILabel *)detailLB{
    if (_detailLB == nil) {
        _detailLB = [[UILabel alloc] init];
        [self addSubview:_detailLB];
        [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headIV.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(self.nameLB.mas_bottom).mas_equalTo(4);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(-15);
        }];
        _detailLB.font = [UIFont systemFontOfSize:12];
        _detailLB.textColor = [Utils colorRGB:@"#666666"];
    }
    return _detailLB;
}

- (void)setMessageModel:(MessageModel *)messageModel{
    _messageModel = messageModel;
    [self.headIV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"image1"]];
    self.nameLB.text = messageModel.message_id;
    self.detailLB.text = messageModel.title;
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
