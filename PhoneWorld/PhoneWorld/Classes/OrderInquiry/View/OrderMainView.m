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
@property (nonatomic) ContentView *contentScrollView;

@property (nonatomic) UIView *grayView;//灰色
@property (nonatomic) UITapGestureRecognizer *tapGrayGR;

@property (nonatomic) NSArray *arrTitles;

@property (nonatomic) UIView *yellowLineView;

@end

@implementation OrderMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        /*----top栏-----*/
        self.topView = [[TopView alloc] initWithFrame:CGRectZero andTitles:@[@"成卡开户",@"白卡开户",@"过户",@"补卡",@"话费充值"]];
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
            make.bottom.mas_equalTo(-20);
        }];
        self.contentScrollView.delegate = self;
        self.contentScrollView.scrollEnabled = NO;
        
        [self grayView];
        
        /*-----筛选框new--------*/
        self.selectView = [[FilterView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, 240)];
        self.selectView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.selectView];
        self.selectView.hidden = YES;
        self.selectView.orderStates = @[@"全部",@"已激活",@"锁定",@"开户中",@"已使用",@"失效"];
        
        
        __block __weak OrderMainView *weakself = self;
        
        /*----------topView点击事件---------*/
        [self.topView setCallback:^(NSInteger tag) {
            /*---按钮点击事件---*/
            [weakself.contentScrollView setContentOffset:CGPointMake(screenWidth*(tag - 10), 0)];
            NSInteger i = tag - 10;
            UIButton *button = weakself.topView.titlesButton[i];
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = weakself.yellowLineView.frame;
                frame.origin.x = button.origin.x;
                frame.size.width = button.size.width;
                weakself.yellowLineView.frame = frame;
                [weakself layoutIfNeeded];
            }];
            
            if (weakself.selectView.hidden == NO) {
                weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
                [UIView animateWithDuration:0.3 animations:^{
                    weakself.selectView.alpha = 0;
                    weakself.grayView.alpha = 0;
                } completion:^(BOOL finished) {
                    weakself.selectView.hidden = YES;
                    weakself.grayView.hidden = YES;
                }];
            }
            
        }];
        
        [self.topView setTopCallBack:^(id obj) {
            // 点击筛选栏时的操作
            if (weakself.selectView.hidden == NO) {
                weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
                [UIView animateWithDuration:0.3 animations:^{
                    weakself.selectView.alpha = 0;
                    weakself.grayView.alpha = 0;
                } completion:^(BOOL finished) {
                    weakself.selectView.hidden = YES;
                    weakself.grayView.hidden = YES;
                }];
            }else{
                weakself.topView.showButton.transform = CGAffineTransformIdentity;
                weakself.selectView.hidden = NO;
                weakself.grayView.hidden = NO;
                weakself.selectView.alpha = 0;
                weakself.grayView.alpha = 0;
                [UIView animateWithDuration:0.3 animations:^{
                    weakself.selectView.alpha = 1;
                    weakself.grayView.alpha = 0.5;
                } completion:^(BOOL finished) {
                }];
            }
//            weakself.selectView.hidden = weakself.selectView.hidden == YES ? NO:YES;
//            weakself.grayView.hidden = weakself.grayView.hidden == YES ? NO:YES;
        }];
        
        //点击筛选框查询按钮操作
        [self.selectView setFilterCallBack:^(NSArray *array,NSString *string) {
            NSLog(@"-----%@------",array);
            
            for (int i = 0; i < array.count; i++) {
                UILabel *lb = weakself.topView.resultArr[i];
                if (array[i]) {
                    lb.text = [NSString stringWithFormat:@"%@%@",weakself.arrTitles[i],array[i]];
                }
            }
            
            [weakself.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(130);
            }];
            
            [[OpenAccomplishCardViewController sharedOpenAccomplishCardViewController].orderView.orderTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44 - 20);
                make.width.mas_equalTo(screenWidth);
            }];
            
            [[OpenWhiteCardViewController sharedOpenWhiteCardViewController].orderView.orderTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44 - 20);
                make.width.mas_equalTo(screenWidth);
            }];
            
            [[TransferViewController sharedTransferViewController].orderView.orderTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44 - 20);
                make.width.mas_equalTo(screenWidth);
            }];
            
            [[RepairCardViewController sharedRepairCardViewController].orderView.orderTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44 - 20);
                make.width.mas_equalTo(screenWidth);
            }];
            
            [[TopUpViewController sharedTopUpViewController].orderTwoView.orderTwoTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(screenHeight - 130 - 64 - 44 - 20);
                make.width.mas_equalTo(screenWidth);
            }];
            
            weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
            if ([string isEqualToString:@"查询"]) {
                weakself.selectView.hidden = YES;
                weakself.grayView.hidden = YES;
            }
            
        }];
        
        [self.selectView setDismissPickerViewCallBack:^(id obj) {
            weakself.selectView.beginDatePicker.hidden = YES;
            weakself.selectView.pickView.hidden = YES;
            weakself.selectView.pickerView.hidden = YES;
            weakself.selectView.closeImagePickerButton.hidden = YES;
            weakself.selectView.cancelButton.hidden = YES;
        }];
        
        [self yellowLineView];
        
    }
    return self;
}

- (UIView *)yellowLineView{
    if (_yellowLineView == nil) {
        UIButton *button = self.topView.titlesButton.firstObject;
        _yellowLineView = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x, 39, button.size.width, 1)];
        [self addSubview:_yellowLineView];
        _yellowLineView.backgroundColor = MainColor;
    }
    return _yellowLineView;
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
            make.height.mas_equalTo(screenHeight - 108 - 80 - 245);
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
    if (weakself.selectView.hidden == NO) {
        weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
        [UIView animateWithDuration:0.3 animations:^{
            weakself.selectView.alpha = 0;
            weakself.grayView.alpha = 0;
        } completion:^(BOOL finished) {
            weakself.selectView.hidden = YES;
            weakself.grayView.hidden = YES;
        }];
    }else{
        weakself.topView.showButton.transform = CGAffineTransformIdentity;
        weakself.selectView.hidden = NO;
        weakself.grayView.hidden = NO;
        weakself.selectView.alpha = 0;
        weakself.grayView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            weakself.selectView.alpha = 1;
            weakself.grayView.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
    }
}

@end
