//
//  TopAndInquiryViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopAndInquiryViewController.h"
#import "DropDownView.h"
#import "TopView.h"
#import "OrderTwoView.h"

@interface TopAndInquiryViewController ()
@property (nonatomic) DropDownView *selectView;//  筛选栏
@property (nonatomic) TopView *topView;// 头部栏
@property (nonatomic) UIView *grayView;//灰色
@property (nonatomic) UITapGestureRecognizer *tapGrayGR;
@property (nonatomic) UIView *lineView;
@property (nonatomic) OrderTwoView *orderTwoView;
@end

@implementation TopAndInquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值查询";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self grayView];
    
    /*---页头---*/
    self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 80) andTitles:@[@"全部",@"话费充值",@"余额充值"]];
    [self.view addSubview:self.topView];
    
    self.orderTwoView = [[OrderTwoView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, screenHeight)];
    [self.view addSubview:self.orderTwoView];
    [self.orderTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(screenHeight - 64 - 80);
    }];
    
    self.selectView = [[DropDownView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, 220)];
    self.selectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectView];
    self.selectView.hidden = YES;
    self.selectView.phoneShowBtn.hidden = NO;
    self.selectView.phoneLB.text = @"充值类型：";
    self.selectView.phoneTF.placeholder = @"";
    self.selectView.phoneTF.enabled = NO;
    self.selectView.states = @[@"全部",@"成功",@"失败",@"待定",@"出错"];
    [self.selectView.stateTableView reloadData];
    __block __weak TopAndInquiryViewController *weakself = self;
    [self.selectView setDropDownCallBack:^(NSInteger tag) {
        if (tag == 50) {
            //查询操作
            weakself.topView.orderTimeLB.text = [NSString stringWithFormat:@"订单时间：%@-%@",weakself.selectView.beginTime.text,weakself.selectView.endTime.text];
            weakself.topView.orderStateLB.text = [NSString stringWithFormat:@"订单状态：%@",weakself.selectView.stateTF.text];
            weakself.topView.orderPhoneLB.text = [NSString stringWithFormat:@"充值类型：%@",weakself.selectView.phoneTF.text];
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = weakself.topView.frame;
                frame.size.height = 155;
                weakself.topView.frame = frame;
                
                if (weakself.selectView.hidden == NO) {
                    weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
                }else{
                    weakself.topView.showButton.transform = CGAffineTransformIdentity;
                }
                weakself.selectView.hidden = weakself.selectView.hidden == YES ? NO:YES;
                weakself.grayView.hidden = weakself.grayView.hidden == YES ? NO:YES;
            }];
        }

    }];
    
    [self.topView setCallback:^(NSInteger tag) {
        switch (tag) {
            case 101:{//出现筛选框按钮
                [UIView animateWithDuration:0.3 animations:^{
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
            default:
            {
                [UIView animateWithDuration:0.5 animations:^{
                    CGRect frame = weakself.lineView.frame;
                    frame = CGRectMake((tag - 10)*(screenWidth/3.0), 39, screenWidth/3.0, 1);
                    weakself.lineView.frame = frame;
                }];
            }
                break;
        }
    }];
    [self lineView];
}

#pragma mark - LazyLoading
- (UIView *)grayView{
    if (_grayView == nil) {
        _grayView = [[UIView alloc] init];
        [self.view addSubview:_grayView];
        _grayView.backgroundColor = [UIColor lightGrayColor];
        _grayView.alpha = 0.5;
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(screenHeight - 64 - 80 - 220);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        _grayView.hidden = YES;
        [_grayView addGestureRecognizer:self.tapGrayGR];
    }
    return _grayView;
}

- (UITapGestureRecognizer *)tapGrayGR{
    if (_tapGrayGR == nil) {
        _tapGrayGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    }
    return _tapGrayGR;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, screenWidth/3, 1)];
        [self.view addSubview:_lineView];
        _lineView.backgroundColor = MainColor;
    }
    return _lineView;
}

#pragma mark - Method
- (void)tapAction{
    [self.view endEditing:YES];
    __block __weak TopAndInquiryViewController *weakself = self;
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
