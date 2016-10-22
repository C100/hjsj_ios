//
//  OrderMainView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/22.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderMainView.h"
#import "FilterView.h"
#import "TopView.h"
#import "ContentView.h"

#import "OpenAccomplishCardViewController.h"
#import "OpenWhiteCardViewController.h"
#import "TransferViewController.h"
#import "RepairCardViewController.h"
#import "TopUpViewController.h"

@interface OrderMainView ()

@property (nonatomic) TopView *topView;//标题栏
@property (nonatomic) FilterView *selectView;//筛选new
@property (nonatomic) UIView *grayView;//灰色
@property (nonatomic) UITapGestureRecognizer *tapGrayGR;
@property (nonatomic) ContentView *contentScrollView;

@property (nonatomic) NSArray *arr;
@property (nonatomic) NSArray *arrTitles;

@end

@implementation OrderMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /*----top栏-----*/
        self.topView = [[TopView alloc] initWithFrame:CGRectZero andTitles:@[@"成卡开户",@"白卡开户",@"过户",@"补卡",@"充值"]];
        self.arrTitles = @[@"起始时间：",@"截止时间：",@"订单状态：",@"手机号码："];
        [self addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(80);
        }];
        
        /*---内容--*/
        self.contentScrollView = [[ContentView alloc] init];
        [self addSubview:self.contentScrollView];
        [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        self.contentScrollView.delegate = self;
        
        [self grayView];
        
        /*-----筛选框new--------*/
        self.selectView = [[FilterView alloc] initWithFrame:CGRectMake(0, 81, screenWidth, 240)];
        self.selectView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.selectView];
        self.selectView.hidden = YES;
        self.selectView.orderStates = @[@"全部",@"已激活",@"锁定",@"开户中",@"已使用",@"失效"];
        
        
        __block __weak OrderMainView *weakself = self;
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
                    //10 11 12 13 14
                    [weakself.contentScrollView setContentOffset:CGPointMake(screenWidth*(tag - 10), 0)];
                    
                    
                    
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
        
        //点击筛选框查询按钮操作
        [self.selectView setFilterCallBack:^(NSString *beginDate, NSString *endDate, NSString *third, NSString *forth) {
            NSLog(@"-----%@------%@",beginDate,endDate);
            weakself.arr = @[beginDate,endDate,third,forth];
            for (int i = 0; i < self.arr.count; i++) {
                UILabel *lb = weakself.topView.resultArr[i];
                if (weakself.arr[i]) {
                    lb.text = [NSString stringWithFormat:@"%@%@",weakself.arrTitles[i],weakself.arr[i]];
                    if (i == self.arr.count - 1) {
                        if ([weakself.selectView.titles.lastObject isEqualToString:@"请选择"]) {
                            lb.text = [NSString stringWithFormat:@"充值类型：%@",weakself.arr[i]];
                        }
                    }
                }
            }
            
            [weakself.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(130);
            }];
            
#warning 更新约束
            [[OpenAccomplishCardViewController sharedOpenAccomplishCardViewController].orderView.orderTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44);
                make.width.mas_equalTo(screenWidth);
            }];
            
            [[OpenWhiteCardViewController sharedOpenWhiteCardViewController].orderView.orderTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44);
                make.width.mas_equalTo(screenWidth);
            }];
            
            [[TransferViewController sharedTransferViewController].orderView.orderTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44);
                make.width.mas_equalTo(screenWidth);
            }];
            
            [[RepairCardViewController sharedRepairCardViewController].orderView.orderTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44);
                make.width.mas_equalTo(screenWidth);
            }];
            
            [[TopUpViewController sharedTopUpViewController].orderTwoView.orderTwoTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44);
                make.width.mas_equalTo(screenWidth);
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

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/screenWidth;
    for (UIButton *b in self.topView.titlesButton) {
        b.selected = NO;
    }
    UIButton *btn = self.topView.titlesButton[page];
    btn.selected = YES;
    self.selectView.titles = @[@"起始时间",@"截止时间",@"订单状态",@"手机号码"];
    self.selectView.details = @[@"请选择",@"请选择",@"请选择",@"请输入手机号码"];
    //筛选new
    if (page == 0 || page == 1) {
        self.selectView.orderStates = @[@"全部",@"已激活",@"锁定",@"开户中",@"已使用",@"失效"];
    }
    
    if (page == 2 || page == 3) {
        self.selectView.orderStates = @[@"全部",@"待审核",@"审核通过",@"审核不通过"];
    }
    
    if (page == 4) {//充值
        self.selectView.orderStates = @[@"全部",@"成功",@"失败",@"待定",@"出错"];
        self.selectView.titles = @[@"起始时间",@"截止时间",@"订单状态",@"充值类型"];
        self.selectView.details = @[@"请选择",@"请选择",@"请选择",@"请选择"];
    }
    [self.selectView.filterTableView reloadData];
    
}

#pragma mark - LazyLoading
- (UIView *)grayView{
    if (_grayView == nil) {
        _grayView = [[UIView alloc] init];
        [self addSubview:_grayView];
        _grayView.backgroundColor = [UIColor lightGrayColor];
        _grayView.alpha = 0.5;
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(screenHeight - 108 - 80 - 220);
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
    [self endEditing:YES];
    __block __weak OrderMainView *weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (weakself.selectView.hidden == NO) {
            weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
            weakself.selectView.hidden = YES;
            weakself.grayView.hidden = YES;
        }else{
            weakself.topView.showButton.transform = CGAffineTransformIdentity;
            weakself.selectView.hidden = NO;
            weakself.grayView.hidden = NO;
        }
    }];
}

@end
