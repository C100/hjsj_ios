//
//  OrderViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderViewController.h"
#import "DropDownView.h"
#import "TopView.h"
#import "ContentView.h"

#define selectV 220/375.0

@interface OrderViewController ()<UIScrollViewDelegate>

@property (nonatomic) DropDownView *selectView;//筛选
@property (nonatomic) TopView *topView;//标题栏
@property (nonatomic) UIView *grayView;//灰色
@property (nonatomic) UITapGestureRecognizer *tapGrayGR;

@property (nonatomic) ContentView *contentScrollView;

@end

@implementation OrderViewController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    /*---内容--*/
    self.contentScrollView = [[ContentView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, screenHeight - 108 - 80)];
    [self.view addSubview:self.contentScrollView];
    self.contentScrollView.delegate = self;
    
    /*---页头---*/
    self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 80) andTitles:@[@"成卡开户",@"白卡开户",@"过户",@"补卡",@"充值"]];
    [self.view addSubview:self.topView];
    
    self.selectView = [[DropDownView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, 220)];
    self.selectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectView];
    self.selectView.hidden = YES;
    
    [self grayView];
    
    __block __weak OrderViewController *weakself = self;
    [self.topView setCallback:^(NSInteger tag) {
        /*---按钮点击事件---*/
        
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
                
            default:{
                //10 11 12 13 14
                [weakself.contentScrollView setContentOffset:CGPointMake(screenWidth*(tag - 10), 0)];
            }
                break;
        }
        
    }];
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/screenWidth;
    for (UIButton *b in self.topView.titlesButton) {
        b.selected = NO;
    }
    UIButton *btn = self.topView.titlesButton[page];
    btn.selected = YES;
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

#pragma mark - Method
- (void)tapAction{
    [self.view endEditing:YES];
    __block __weak OrderViewController *weakself = self;
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
