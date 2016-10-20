//
//  FailedView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "FailedView.h"

@interface FailedView ()

@property (nonatomic) NSString *titleStr;
@property (nonatomic) NSString *detailStr;
@property (nonatomic) NSString *imageName;

@end

@implementation FailedView
- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andDetail:(NSString *)detail andImageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor blackColor];
//        self.alpha = 0.4;
        self.titleStr = title;
        self.detailStr = detail;
        self.imageName = imageName;
        
        UIView *v = [[UIView alloc] init];
        [self addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        v.backgroundColor = [UIColor blackColor];
        v.alpha = 0.4;
        
        [self stateView];
    }
    return self;
}

- (UIView *)stateView{
    _stateView = [[UIView alloc] init];
    [self addSubview:_stateView];
    [_stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(90);
    }];
    _stateView.backgroundColor = [UIColor whiteColor];
    _stateView.layer.cornerRadius = 10;
    _stateView.layer.masksToBounds = YES;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [_stateView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(87);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(24);
    }];
    imageV.image = [UIImage imageNamed:self.imageName];
    imageV.contentMode = UIViewContentModeScaleToFill;
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = self.titleStr;
    [_stateView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV.mas_right).mas_equalTo(8);
        make.top.mas_equalTo(23);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(18);
    }];
    lb.font = [UIFont systemFontOfSize:16];

    if ([self.titleStr isEqualToString:@"提交成功"]) {
        lb.textColor = [Utils colorRGB:@"#ec6c00"];
    }else if([self.titleStr isEqualToString:@"读卡失败"]){
        lb.textColor = [Utils colorRGB:@"#0081eb"];
    }else{
        lb.textColor = [Utils colorRGB:@"#333333"];
    }
    
    UILabel *lb2 = [[UILabel alloc] init];
    lb2.text = self.detailStr;
    [_stateView addSubview:lb2];
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-23);
        make.height.mas_equalTo(14);
    }];
    lb2.font = [UIFont systemFontOfSize:12];
    lb2.textColor = [Utils colorRGB:@"#333333"];
    
    return _stateView;
}

@end
