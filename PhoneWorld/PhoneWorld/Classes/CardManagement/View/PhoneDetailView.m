//
//  PhoneDetailView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneDetailView.h"

@interface PhoneDetailView ()

@property (nonatomic) NSArray *leftDistance;
@property (nonatomic) NSArray *titles;

@end

@implementation PhoneDetailView

- (instancetype)initWithFrame:(CGRect)frame andPhoneInfo:(NSArray *)phoneInfo
{
    self = [super initWithFrame:frame];
    if (self) {
        self.phoneInfo = phoneInfo;
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        [self addSubview:v];
        v.backgroundColor = [UIColor blackColor];
        v.alpha = 0.4;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteFromSuperViewAction)];
        [v addGestureRecognizer:tap];
        
        self.leftDistance = @[@18,@106,@188];
        self.titles = @[@"靓号规则",@"预存",@"号码说明"];
        [self addInfo];
    }
    return self;
}

- (void)addInfo{
    
    UIView *v = [[UIView alloc] init];
    [self addSubview:v];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 6;
    v.layer.masksToBounds = YES;
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(80);
    }];
    
    NSArray *widthArr = @[@63,@49,@96];
    
    for (int i = 0; i < self.leftDistance.count; i++) {
        UILabel *lb = [[UILabel alloc] init];
        [v addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftDistance[i]);
            make.top.mas_equalTo(11);
        }];
        lb.textColor = [Utils colorRGB:@"#333333"];
        lb.font = [UIFont systemFontOfSize:textfont12];
        lb.text = self.titles[i];
        
        UILabel *lb2 = [[UILabel alloc] init];
        [v addSubview:lb2];
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(lb.mas_centerX);
            make.centerY.mas_equalTo(20);
            make.width.mas_equalTo(widthArr[i]);
            make.height.mas_equalTo(40);
        }];
        lb2.numberOfLines = 0;
        lb2.textAlignment = NSTextAlignmentCenter;
        lb2.textColor = [Utils colorRGB:@"#333333"];
        lb2.font = [UIFont systemFontOfSize:textfont12];
        lb2.text = self.phoneInfo[i];
        
    }
    
    NSArray *leftD = @[@83,@153];
    for (int i = 0; i < leftD.count; i ++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor  =[Utils colorRGB:@"#efefef"];
        [v addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftD[i]);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(80);
            make.top.mas_equalTo(0);
        }];
    }
    
    UIView *lineViewH = [[UIView alloc] init];
    lineViewH.backgroundColor  =[Utils colorRGB:@"#efefef"];
    [v addSubview:lineViewH];
    [lineViewH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(0);
    }];
}

#pragma mark - Method

- (void)deleteFromSuperViewAction{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
