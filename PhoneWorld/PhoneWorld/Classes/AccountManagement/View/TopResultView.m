//
//  TopResultView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopResultView.h"

@implementation TopResultView

- (instancetype)initWithFrame:(CGRect)frame andIsSucceed:(BOOL)isSucceed
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isSucceed = isSucceed;
        self.backgroundColor = COLOR_BACKGROUND;
        self.detailArr = @[@"编号：",@"日期：",@"类型：",@"金额：",@"号码：",@"状态："];
        [self stateView];
        [self detailView];
        [self nextButton];
        [self backToHomeButton];
    }
    return self;
}

- (UIView *)stateView{
    if (_stateView == nil) {
        _stateView = [[UIView alloc] init];
        _stateView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_stateView];
        [_stateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(48);
        }];
        UIButton *button = [[UIButton alloc] init];
        [_stateView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        
        NSString *imageName = nil;
        NSString *title = nil;
        NSString *color = nil;
        if (self.isSucceed == YES) {
            imageName = @"icon_smile";
            title = @"  支付成功！";
            color = @"#eb000c";
        }else{
            imageName = @"icon_cry";
            title = @"  支付失败！";
            color = @"#0081eb";
        }
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[Utils colorRGB:color] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        button.userInteractionEnabled = NO;
    }
    return _stateView;
}

- (UIView *)detailView{
    if (_detailView == nil) {
        _detailView = [[UIView alloc] init];
        _detailView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_detailView];
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.stateView.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(91);
        }];
        
        for (int i = 0; i<self.detailArr.count; i++) {
            CGFloat line = i%2;
            CGFloat queue = i/2;
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15 + ((screenWidth-30)/2.0)*line, 10 + (27*queue), (screenWidth-30)/2.0, 14)];
            lb.text = self.detailArr[i];
            lb.font = [UIFont systemFontOfSize:12];
            lb.textColor = [Utils colorRGB:@"#666666"];
            [_detailView addSubview:lb];
        }
        
    }
    return _detailView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.detailView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton setTitle:@"继续充值" forState:UIControlStateNormal];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UIButton *)backToHomeButton{
    if (_backToHomeButton == nil) {
        _backToHomeButton = [[UIButton alloc] init];
        [self addSubview:_backToHomeButton];
        [_backToHomeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.nextButton.mas_bottom).mas_equalTo(20);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"返回首页"];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [str addAttribute:NSForegroundColorAttributeName value:[Utils colorRGB:@"#0081eb"] range:strRange];
        [_backToHomeButton setAttributedTitle:str forState:UIControlStateNormal];
        [_backToHomeButton setTitleColor:[Utils colorRGB:@"#0081eb"] forState:UIControlStateNormal];
        _backToHomeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_backToHomeButton addTarget:self action:@selector(backToHomeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backToHomeButton;
}

#pragma mark - Method 
- (void)nextAction:(UIButton *)button{
    UIViewController *controller = [self viewController];
    [controller.navigationController popViewControllerAnimated:YES];
}

- (void)backToHomeAction{
    UIViewController *viewController = [self viewController];
    [viewController.navigationController popToRootViewControllerAnimated:YES];
}

@end
