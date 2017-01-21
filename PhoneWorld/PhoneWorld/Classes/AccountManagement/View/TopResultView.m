//
//  TopResultView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopResultView.h"
#import "MainTabBarController.h"

@interface TopResultView ()

@property (nonatomic) NSMutableArray *allResultsLabelArray;
@property (nonatomic) UILabel *detailLabel;

@end

@implementation TopResultView

- (instancetype)initWithFrame:(CGRect)frame andIsSucceed:(BOOL)isSucceed
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isSucceed = isSucceed;
        self.backgroundColor = COLOR_BACKGROUND;
        self.detailArr = @[@"编号：",@"日期：",@"类型：",@"金额：",@"号码："];
        self.allResultsLabelArray = [NSMutableArray array];
        [self stateView];
        [self detailView];
        [self nextButton];
        [self backToHomeButton];
    }
    return self;
}

- (void)setAllResults:(NSArray *)allResults{
    _allResults = allResults;
    
    for (int i = 0; i < self.detailArr.count; i ++) {
        UILabel *lb = self.allResultsLabelArray[i];
        lb.text = [NSString stringWithFormat:@"%@%@",self.detailArr[i],self.allResults[i]];
    }
    if (self.allResults.count > 5) {
        self.detailLabel.text = self.allResults[5];
    }
    
}

- (UIView *)stateView{
    if (_stateView == nil) {
        _stateView = [[UIView alloc] init];
        _stateView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_stateView];
        
        CGFloat height = 48.0;
        CGFloat bottom = 0;

        NSString *imageName = nil;
        NSString *title = nil;
        NSString *color = nil;
        NSString *detailString = nil;
        if (self.isSucceed == YES) {
            imageName = @"icon_smile";
            title = @"  支付成功！";
            color = @"#eb000c";
        }else{
            imageName = @"icon_cry";
            title = @"  支付失败！";
            color = @"#0081eb";
            detailString = @"支付失败";
            height = 68;
            bottom = -20;
        }
        
        
        [_stateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(height);
        }];
        UIButton *button = [[UIButton alloc] init];
        [_stateView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(bottom);
        }];
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[Utils colorRGB:color] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:textfont20];
        button.userInteractionEnabled = NO;
        
        if (self.isSucceed == NO) {
            UILabel *detailLabel = [[UILabel alloc] init];
            [_stateView addSubview:detailLabel];
            [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(0);
                make.top.mas_equalTo(button.mas_bottom).mas_equalTo(0);
            }];
            detailLabel.text = detailString;
            detailLabel.textAlignment = NSTextAlignmentCenter;
            detailLabel.textColor = [Utils colorRGB:color];
            detailLabel.font = [UIFont systemFontOfSize:textfont12];
            self.detailLabel = detailLabel;
        }
        
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
            CGFloat line = (i+1)%2;
            CGFloat queue = (i+1)/2;
            if (i == 0) {
                UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, screenWidth-30, 14)];
                lb.text = self.detailArr[i];
                lb.font = [UIFont systemFontOfSize:textfont12];
                lb.textColor = [Utils colorRGB:@"#666666"];
                [_detailView addSubview:lb];
                [self.allResultsLabelArray addObject:lb];
            }else{
                UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15 + ((screenWidth-30)/2.0)*line, 10 + (27*queue), (screenWidth-30)/2.0, 14)];
                lb.text = self.detailArr[i];
                lb.font = [UIFont systemFontOfSize:textfont12];
                lb.textColor = [Utils colorRGB:@"#666666"];
                [_detailView addSubview:lb];
                [self.allResultsLabelArray addObject:lb];
            }
        }
    }
    return _detailView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"继续充值"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.detailView.mas_bottom).mas_equalTo(40);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(self.backToHomeButton.mas_width);
            make.right.mas_equalTo(self.backToHomeButton.mas_left).mas_equalTo(-15);
        }];
        [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UIButton *)backToHomeButton{
    if (_backToHomeButton == nil) {
        
        _backToHomeButton = [Utils returnNextButtonWithTitle:@"返回首页"];
        [self addSubview:_backToHomeButton];
        [_backToHomeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.detailView.mas_bottom).mas_equalTo(40);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(self.nextButton.mas_width);
            make.left.mas_equalTo(self.nextButton.mas_right).mas_equalTo(15);
        }];
        [_backToHomeButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backToHomeButton;
}

#pragma mark - Method 
- (void)nextAction:(UIButton *)button{
    UIViewController *controller = [self viewController];
    if ([button.currentTitle isEqualToString:@"继续充值"]) {
        [controller.navigationController popViewControllerAnimated:YES];
    }else{
        [controller.navigationController popToRootViewControllerAnimated:YES];

        
//        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeSelectViewController) userInfo:nil repeats:NO];
        
    }
}

- (void)changeSelectViewController{
    MainTabBarController *mainTab = (MainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    mainTab.selectedViewController = mainTab.viewControllers.firstObject;
}

@end
