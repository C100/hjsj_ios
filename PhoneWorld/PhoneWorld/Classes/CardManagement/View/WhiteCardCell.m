//
//  WhiteCardCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "WhiteCardCell.h"
#import "PhoneDetailView.h"

@implementation WhiteCardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self leftButton];
        [self rightButton];
        [self phoneLB];
    }
    return self;
}

- (void)setWhitePhoneModel:(WhitePhoneModel *)whitePhoneModel{
    _whitePhoneModel = whitePhoneModel;
    
    self.phoneLB.text = whitePhoneModel.num;
    
}

- (UIButton *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [[UIButton alloc] init];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.height.mas_equalTo(10);
        }];
        _leftButton.backgroundColor = [Utils colorRGB:@"#ffffff"];
        _leftButton.layer.borderColor = [Utils colorRGB:@"#cccccc"].CGColor;
        _leftButton.layer.borderWidth = 1;
        _leftButton.layer.cornerRadius = 5;
        _leftButton.layer.masksToBounds = YES;
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc] init];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.width.height.mas_equalTo(30);
        }];
        [_rightButton setImage:[UIImage imageNamed:@"detail"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        [self addSubview:_phoneLB];
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.leftButton.mas_right).mas_equalTo(5);
            make.right.mas_equalTo(self.rightButton.mas_right).mas_equalTo(-10);
        }];
        _phoneLB.font = [UIFont systemFontOfSize:textfont14];
        _phoneLB.textColor = [Utils colorRGB:@"#666666"];
    }
    return _phoneLB;
}

#pragma mark - Method
- (void)detailAction:(UIButton *)button{
    NSString *money = [self.whitePhoneModel.infos componentsSeparatedByString:@","].firstObject;
    NSString *moneyNumber = [money componentsSeparatedByString:@"存"].lastObject;
    PhoneDetailView *detailView = [[PhoneDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andPhoneInfo:@[self.whitePhoneModel.rules,moneyNumber,self.whitePhoneModel.infos]];
    [[UIApplication sharedApplication].keyWindow addSubview:detailView];
}

@end
