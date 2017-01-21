//
//  TopCallMoneyViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopCallMoneyViewController.h"
#import "TopCallMoneyView.h"
#import "PayView.h"
#import "TopResultViewController.h"

@interface TopCallMoneyViewController ()
@property (nonatomic) TopCallMoneyView *topCallMoneyView;

@property (nonatomic) NSArray *discountArray;
@end

@implementation TopCallMoneyViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestAccountMoney];

    [IQKeyboardManager sharedManager].enable = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"话费充值";

    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.discountArray = [NSArray array];
    
    self.topCallMoneyView = [[TopCallMoneyView alloc] init];
    [self.view addSubview:self.topCallMoneyView];
    [self.topCallMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self requestDiscountInfo];
    
    __block __weak TopCallMoneyViewController *weakself = self;
    
    [self.topCallMoneyView setTopCallMoneyCallBack:^(CGFloat money, NSString *phone, NSString *numbers, NSString *status) {        
        
        NSMutableArray *allResults = [NSMutableArray array];
        NSDate *currentDate = [NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        
        NSString *locationString=[dateformatter stringFromDate:currentDate];
        
        NSString *moneyStr = [NSString stringWithFormat:@"%.2f",money];
        [allResults addObjectsFromArray:@[numbers,locationString,@"话费充值",moneyStr,phone,status]];
        
        TopResultViewController *resultView = [TopResultViewController new];
        resultView.isSucceed = NO;
        resultView.allResults = allResults;
        if ([status isEqualToString:@"支付成功"]) {
            resultView.isSucceed = YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.topCallMoneyView endEditing:YES];
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = weakself.topCallMoneyView.payView.frame;
                frame.origin.y = screenHeight;
                weakself.topCallMoneyView.payView.frame = frame;
                weakself.topCallMoneyView.grayView.alpha = 0;
            } completion:^(BOOL finished) {
                [weakself.topCallMoneyView.grayView removeFromSuperview];
                [weakself.navigationController pushViewController:resultView animated:YES];
            }];
        });
    }];
}

//返回账户当前余额
- (void)requestAccountMoney{
    __block __weak TopCallMoneyViewController *weakself = self;
    [WebUtils requestAccountMoneyWithCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    float money = [[NSString stringWithFormat:@"%@",obj[@"data"][@"balance"]] floatValue];
                    weakself.topCallMoneyView.accountMoneyIV.textField.text = [NSString stringWithFormat:@"%.2f元",money];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [Utils toastview:@"账户余额查询失败"];
                });
            }
        }
    }];
}

//充值优惠
- (void)requestDiscountInfo{
    __block __weak TopCallMoneyViewController *weakself = self;
    [WebUtils requestDiscountInfoWithCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.discountArray = obj[@"data"][@"discount"];
                    weakself.topCallMoneyView.discountArray = weakself.discountArray;
                });
            }else{
                NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [Utils toastview:mes];
                });
            }
        }
    }];
}

@end
