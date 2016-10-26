//
//  SettlementDetailView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "SettlementDetailView.h"
#import "FailedView.h"

@interface SettlementDetailView ()

@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSMutableDictionary *userinfosDic;
@property (nonatomic) UIView *v;
@property (nonatomic) FailedView *finishedView;

@end

@implementation SettlementDetailView

- (instancetype)initWithFrame:(CGRect)frame andUserinfos:(NSMutableDictionary *)userinfos
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.userinfosDic = userinfos;
        self.leftTitles = @[@"开户号码：",@"预存金额：",@"套餐金额：",@"活动包：",@"优惠金额：",@"总金额："];
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
    
    NSString *str = [self.userinfosDic[@"prestoreMoney"] stringByAppendingString:@"元"];
    NSString *money = [NSString stringWithFormat:@"%.2f元",str.floatValue];
    
    NSArray *arr = @[self.userinfosDic[@"phoneNumber"], money, @"79.9元",@"代理渠道商卡包",@"0.00",money];
    for (int i = 0; i < arr.count; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10 + 30*i, screenWidth - 30, 16)];
        [v addSubview:lb];
        lb.textColor = [Utils colorRGB:@"#999999"];
        lb.font = [UIFont systemFontOfSize:14];
        lb.text = [self.leftTitles[i] stringByAppendingString:arr[i]];
    }
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnBextButtonWithTitle:@"提交订单"];
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
    self.finishedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"提交成功" andDetail:@"请耐心等待..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
    [[UIApplication sharedApplication].keyWindow addSubview:self.finishedView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeGrayView) userInfo:nil repeats:NO];
}

- (void)removeGrayView{
    [UIView animateWithDuration:0.5 animations:^{
        self.finishedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.finishedView removeFromSuperview];
        UIViewController *vc = [self viewController];
        [vc.navigationController popToRootViewControllerAnimated:YES];
    }];
}

@end
