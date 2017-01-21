//
//  MessageDetailScrollView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MessageDetailScrollView.h"

@interface MessageDetailScrollView ()

@property (nonatomic) UIView *lineView;
@property (nonatomic) UIView *whiteView;

@end

@implementation MessageDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.contentSize = CGSizeMake(screenWidth, 1500);
        self.bounces = NO;
        
//        [self titleLabel];
//        [self timeLabel];
//        [self detailLabel];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        CGSize titleSize = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont16] andMaxSize:CGSizeMake(screenWidth - 30, 0) andStr:self.detailModel.title];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(titleSize.height);
            make.top.mas_equalTo(10);
        }];
        _titleLabel.text = self.detailModel.title;
        _titleLabel.textColor = [Utils colorRGB:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:textfont16];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(15);
        }];
        _timeLabel.text = [self.detailModel.time componentsSeparatedByString:@"."].firstObject;
        _timeLabel.textColor = [Utils colorRGB:@"#999999"];
        _timeLabel.font = [UIFont systemFontOfSize:textfont14];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.numberOfLines = 0;

        CGSize detailSize = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont14] andMaxSize:CGSizeMake(screenWidth - 30, 0) andStr:self.detailModel.content];
        [self addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_equalTo(40);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(screenWidth - 30);
            make.height.mas_equalTo(detailSize.height+1.0);
            make.bottom.mas_equalTo(-10);
        }];
        _detailLabel.text = self.detailModel.content;
        _detailLabel.textColor = [Utils colorRGB:@"#666666"];
        _detailLabel.font = [UIFont systemFontOfSize:textfont14];
    }
    return _detailLabel;
}

- (void)setDetailModel:(MessageDetailModel *)detailModel{
    _detailModel = detailModel;
    
    [self titleLabel];
    [self timeLabel];
    [self detailLabel];
    //标题
    CGSize titleSize = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont16] andMaxSize:CGSizeMake(screenWidth - 30, 0) andStr:detailModel.title];
    //内容
    CGSize detailSize = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont14] andMaxSize:CGSizeMake(screenWidth - 30, 0) andStr:detailModel.content];
    
    //分割线
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = COLOR_BACKGROUND;
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(screenWidth);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_equalTo(30);
    }];
    
    //白色背景视图
    self.whiteView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, screenWidth, 60+titleSize.height + detailSize.height)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.whiteView];
    [self sendSubviewToBack:self.whiteView];
}


@end
