//
//  SettlementDetailView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "SettlementDetailView.h"

@interface SettlementDetailView ()

@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) UIView *v;

@end

@implementation SettlementDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"开户号码：",@"预存金额：",@"套餐金额：",@"活动包：",@"优惠金额：",@"总金额："];
        self.leftLabelsArray = [NSMutableArray array];
        [self addInfo];
        [self nextButton];
    }
    return self;
}

- (void)addInfo{
    UIView *v = [[UIView alloc] init];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(190);
    }];
    v.backgroundColor = [UIColor whiteColor];
    self.v = v;

    for (int i = 0; i < self.leftTitles.count; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10 + 30*i, screenWidth - 30, 16)];
        [v addSubview:lb];
        lb.textColor = [Utils colorRGB:@"#999999"];
        lb.font = [UIFont systemFontOfSize:textfont16];
        lb.text = self.leftTitles[i];
        [self.leftLabelsArray addObject:lb];
    }
    
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"提交订单"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.v.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method

- (void)buttonClickAction:(UIButton *)button{
    /*
     保存信息并返回首页
     */
    
    _SubmitCallBack(button);

}


@end
