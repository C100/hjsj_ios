
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
        [self detailLB];
        [self nameLB];
    }
    return self;
}

- (UILabel *)nameLB{
    if (_nameLB == nil) {
        _nameLB = [[UILabel alloc] init];
        [self addSubview:_nameLB];
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(16);
        }];
        _nameLB.font = [UIFont systemFontOfSize:textfont16];
        _nameLB.textColor = [Utils colorRGB:@"#333333"];
    }
    return _nameLB;
}

- (UILabel *)detailLB{
    if (_detailLB == nil) {
        _detailLB = [[UILabel alloc] init];
        _detailLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detailLB];
        [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
        }];
        _detailLB.font = [UIFont systemFontOfSize:textfont12];
        _detailLB.textColor = [Utils colorRGB:@"#666666"];
    }
    return _detailLB;
}

- (void)setMessageModel:(MessageModel *)messageModel{
    _messageModel = messageModel;
    self.nameLB.text = messageModel.title;
    self.detailLB.text = [messageModel.updateDate componentsSeparatedByString:@"."].firstObject;
}

@end
