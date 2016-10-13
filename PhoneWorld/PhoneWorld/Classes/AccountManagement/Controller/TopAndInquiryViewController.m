//
//  TopAndInquiryViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopAndInquiryViewController.h"
#import "TopAndInquiryTableView.h"
#import "DropDownView.h"
#import "TopView.h"

@interface TopAndInquiryViewController ()
@property (nonatomic) DropDownView *selectView;//  筛选栏
@property (nonatomic) TopView *topView;// 头部栏
@property (nonatomic) UIView *grayView;//灰色
@property (nonatomic) UITapGestureRecognizer *tapGrayGR;
@property (nonatomic) TopAndInquiryTableView *topAndInquiryTV;
@property (nonatomic) UIView *lineView;
@end

@implementation TopAndInquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值查询";
    self.view.backgroundColor = [UIColor whiteColor];
    self.topAndInquiryTV = [[TopAndInquiryTableView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, screenHeight - 64 - 80) style:UITableViewStyleGrouped];
    [self.view addSubview:self.topAndInquiryTV];
    
    /*---页头---*/
    self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 80) andTitles:@[@"全部",@"话费充值",@"余额充值"]];
    [self.view addSubview:self.topView];
    
    self.selectView = [[DropDownView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, 220)];
    self.selectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectView];
    self.selectView.hidden = YES;
    
    __block __weak TopAndInquiryViewController *weakself = self;
    [self.topView setCallback:^(NSInteger tag) {
        switch (tag) {
            case 101:{//出现筛选框按钮
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
            make.top.mas_equalTo(self.selectView.mas_bottom).mas_equalTo(0);
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
