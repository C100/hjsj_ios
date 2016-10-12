//
//  TopView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopView.h"

#define distanceX (screenWidth - 7*33 - 20)/4.0

@interface TopView()

@property (nonatomic) NSArray *titles;

@end

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titlesButton = [NSMutableArray array];
        [self titlesView];
        [self siftView];
    }
    return self;
}

- (NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@"成卡开户",@"白卡开户",@"过户",@"补卡",@"充值"];
    }
    return _titles;
}

- (UIView *)titlesView{
    if (_titlesView == nil) {
        _titlesView = [[UIView alloc] init];
        [self addSubview:_titlesView];
        [_titlesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(40);
        }];
        
        for (int i = 0; i < 5; i ++) {
            UIButton *btn = [[UIButton alloc] init];
            if (i < 2) {
                btn.frame = CGRectMake(10+66*i+distanceX*i, 10, 66, 20);
            }else{
                btn.frame = CGRectMake(10+66*2 + distanceX*i + 33*(i - 2), 10, 33, 20);
            }
            btn.tag = 10 + i;
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitle:self.titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[Utils colorRGB:@"#333333"] forState:UIControlStateNormal];
            [btn setTitleColor:MainColor forState:UIControlStateSelected];
            btn.selected = NO;
            if (i == 0) {
                btn.selected = YES;
            }
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_titlesView addSubview:btn];
            [self.titlesButton addObject:btn];
        }
        
    }
    return _titlesView;
}

- (UIView *)siftView{
    if (_siftView == nil) {
        _siftView = [[UIView alloc] init];
        [self addSubview:_siftView];
        [_siftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titlesView.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(30);
        }];
        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 3, 20)];
        leftV.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_siftView addSubview:leftV];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, 50, 15)];
        lb.text = @"筛选条件";
        lb.textColor = [Utils colorRGB:@"#008bd5"];
        lb.font = [UIFont systemFontOfSize:12];
        lb.textAlignment = NSTextAlignmentLeft;
        [_siftView addSubview:lb];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(screenWidth - 30, 10, 20, 10);
        [btn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        btn.tag = 101;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_siftView addSubview:btn];
        btn.transform = CGAffineTransformMakeRotation(M_PI_2*2);
    }
    return _siftView;
}

#pragma mark - Method

- (void)btnClicked:(UIButton *)button{
    _callback(button.tag);
}

@end
