//
//  TopAndInquiryView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/20.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopAndInquiryView.h"
#import "TopView.h"
#import "FilterView.h"
#import "OrderTwoView.h"

@interface TopAndInquiryView ()

@property (nonatomic) TopView *topView;
@property (nonatomic) FilterView *selectView;
@property (nonatomic) UIView *grayView;
@property (nonatomic) UIView *lineView;
@property (nonatomic) OrderTwoView *contentView;

@end

@implementation TopAndInquiryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 80) andTitles:@[@"全部",@"话费充值",@"余额充值"]];
        [self addSubview:self.topView];
        
        self.contentView = [[OrderTwoView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, screenHeight - 64 - 80)];
        [self addSubview:self.contentView];
        
        /*-----筛选框new--------*/
        self.selectView = [[FilterView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, 240)];
        self.selectView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.selectView];
        self.selectView.hidden = YES;
        self.selectView.orderStates = @[@"全部",@"成功",@"失败",@"待定",@"出错"];
        
        [self grayView];
        [self lineView];
        
        
        __block __weak TopAndInquiryView *weakself = self;
        [self.topView setCallback:^(NSInteger tag) {
            /*---按钮点击事件---*/
            
            switch (tag) {
                case 101:{//出现筛选框按钮
                    [UIView animateWithDuration:0.5 animations:^{
                        if (weakself.selectView.hidden == NO) {
                            weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
                        }else{
                            weakself.topView.showButton.transform = CGAffineTransformIdentity;
                        }
                        weakself.selectView.hidden = weakself.selectView.hidden == YES ? NO:YES;
                        weakself.grayView.hidden = weakself.grayView.hidden == YES ? NO:YES;
                    }];
                }
                    break;
                    
                default:{
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect frame = weakself.lineView.frame;
                        frame = CGRectMake((tag - 10)*(screenWidth/3.0), 39, screenWidth/3.0, 1);
                        weakself.lineView.frame = frame;
                    }];
                }
                    break;
            }
            
        }];
        
        [self.topView setTopCallBack:^(id obj) {
            [UIView animateWithDuration:0.5 animations:^{
                if (weakself.selectView.hidden == NO) {
                    weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
                }else{
                    weakself.topView.showButton.transform = CGAffineTransformIdentity;
                }
                weakself.selectView.hidden = weakself.selectView.hidden == YES ? NO:YES;
                weakself.grayView.hidden = weakself.grayView.hidden == YES ? NO:YES;
            }];
        }];
        
    }
    return self;
}

- (UIView *)grayView{
    if (_grayView == nil) {
        _grayView = [[UIView alloc] init];
        [self addSubview:_grayView];
        _grayView.backgroundColor = [UIColor lightGrayColor];
        _grayView.alpha = 0.5;
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(self.selectView.mas_bottom).mas_equalTo(0);
        }];
        _grayView.hidden = YES;
        UITapGestureRecognizer *tapGrayGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_grayView addGestureRecognizer:tapGrayGR];
    }
    return _grayView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, screenWidth/3, 1)];
        [self addSubview:_lineView];
        _lineView.backgroundColor = MainColor;
    }
    return _lineView;
}

#pragma mark - Method
- (void)tapAction{
    [self endEditing:YES];
    __block __weak TopAndInquiryView *weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (weakself.selectView.hidden == NO) {
            weakself.selectView.hidden = YES;
            weakself.grayView.hidden = YES;
        }else{
            weakself.selectView.hidden = NO;
            weakself.grayView.hidden = NO;
        }
    }];
}

@end
