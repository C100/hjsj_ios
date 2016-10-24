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
@property (nonatomic) OrderTwoView *contentView;
@property (nonatomic) NSArray *arrTitles;

@end

@implementation TopAndInquiryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.topView = [[TopView alloc] initWithFrame:CGRectZero andTitles:@[@""]];
        [self addSubview:self.topView];
        self.arrTitles = @[@"起始时间：",@"截止时间：",@"订单状态：",@"手机号码："];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(-40);
            make.height.mas_equalTo(80);
        }];
        
        self.contentView = [[OrderTwoView alloc] init];
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        /*-----筛选框new--------*/
        self.selectView = [[FilterView alloc] initWithFrame:CGRectMake(0, 40, screenWidth, 240)];
        self.selectView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.selectView];
        self.selectView.hidden = YES;
        self.selectView.orderStates = @[@"全部",@"成功",@"失败",@"待定",@"出错"];
        
        [self.selectView.pickerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(screenHeight - 64 - 80 - 240 + 40);
        }];
        [self.selectView.beginDatePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(screenHeight - 64 - 80 - 240 + 40);
        }];
        
        [self grayView];
        
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
        
        [self.selectView setFilterCallBack:^(NSArray *array) {
            
            for (int i = 0; i < array.count; i++) {
                UILabel *lb = weakself.topView.resultArr[i];
                if (array[i]) {
                    lb.text = [NSString stringWithFormat:@"%@%@",weakself.arrTitles[i],array[i]];
                    if (i == array.count - 1) {
                        if ([weakself.selectView.titles.lastObject isEqualToString:@"请选择"]) {
                            lb.text = [NSString stringWithFormat:@"充值类型：%@",array[i]];
                        }
                    }
                }
            }
            
            [weakself.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(-40);
                make.height.mas_equalTo(130);
            }];
            [UIView animateWithDuration:0.3 animations:^{
                weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
                weakself.selectView.hidden = YES;
                weakself.grayView.hidden = YES;
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

#pragma mark - Method
- (void)tapAction{
    [self endEditing:YES];
    __block __weak TopAndInquiryView *weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (weakself.selectView.hidden == NO) {
            weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
            weakself.selectView.hidden = YES;
            weakself.grayView.hidden = YES;
        }else{
            weakself.selectView.hidden = NO;
            weakself.grayView.hidden = NO;
            weakself.topView.showButton.transform = CGAffineTransformIdentity;
        }
    }];
}

@end
