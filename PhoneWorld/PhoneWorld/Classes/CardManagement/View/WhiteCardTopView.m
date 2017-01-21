//
//  WhiteCardFilterView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/24.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "WhiteCardTopView.h"

@interface WhiteCardTopView ()

@property (nonatomic) UIView *headView;
@property (nonatomic) NSArray *titlesArr;

@end

@implementation WhiteCardTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self headView];
        self.backgroundColor = [UIColor whiteColor];
        self.titlesArr = @[@"号码池：",@"靓号规则："];
        self.resultArr = [NSMutableArray array];
        [self resultView];
    }
    return self;
}

- (UIView *)resultView{
    if (_resultView == nil) {
        _resultView = [[UIView alloc] init];
        [self addSubview:_resultView];
        [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.headView.mas_bottom).mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(screenWidth);
        }];
        for (int i = 0; i < 2; i++) {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15+i*(screenWidth-30)/2, 10, (screenWidth-30)/2, 14)];
            lb.font = [UIFont systemFontOfSize:textfont12];
            lb.textColor = [Utils colorRGB:@"#999999"];
            lb.text = self.titlesArr[i];
            [_resultView addSubview:lb];
            [self.resultArr addObject:lb];
        }
        _resultView.hidden = YES;
    }
    return _resultView;
}

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc] init];
        [self addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(40);
        }];
        
        UITapGestureRecognizer *tapHeadView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadViewAction:)];
        [_headView addGestureRecognizer:tapHeadView];
        
        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(10, 9, 3, 20)];
        leftV.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_headView addSubview:leftV];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 100, 15)];
        lb.text = @"筛选条件";
        lb.textColor = [Utils colorRGB:@"#008bd5"];
        lb.font = [UIFont systemFontOfSize:textfont12];
        lb.textAlignment = NSTextAlignmentLeft;
        [_headView addSubview:lb];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(screenWidth - 30, 14, 20, 10);
        [btn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        btn.tag = 101;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:btn];
        btn.transform = CGAffineTransformMakeRotation(M_PI_2*2);
        self.showButton = btn;
    }
    return _headView;
}

#pragma mark - Method
- (void)tapHeadViewAction:(UITapGestureRecognizer *)tap{
    _WhiteCardTopCallBack(tap);
}

- (void)btnClicked:(UIButton *)button{
    _WhiteCardTopCallBack(button);
}

@end
