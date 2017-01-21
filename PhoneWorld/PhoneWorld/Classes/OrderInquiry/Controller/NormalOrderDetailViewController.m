//
//  NormalOrderViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "NormalOrderDetailViewController.h"
#import "NormalOrderDetailView.h"
#import "OrderDetailModel.h"

@interface NormalOrderDetailViewController ()
@property (nonatomic) NormalOrderDetailView *normalOrderDetailView;

@property (nonatomic) OrderDetailModel *detailModel;

@property (nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation NormalOrderDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";//成卡和白卡的订单详情
    self.view.backgroundColor = [UIColor whiteColor];
    self.normalOrderDetailView = [[NormalOrderDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    self.normalOrderDetailView.orderModel = self.orderModel;
    [self.view addSubview:self.normalOrderDetailView];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.frame = CGRectMake(0, 0, 100, 100);
    self.indicatorView.center = CGPointMake(screenWidth/2, (screenHeight-64)/2);
    [self.view addSubview:self.indicatorView];
    [self.indicatorView setHidesWhenStopped:YES];
    [self.indicatorView startAnimating];
    
    [self requestOrderDetail];
    
}

- (void)requestOrderDetail{
    __block __weak NormalOrderDetailViewController *weakself = self;
    [WebUtils requestOrderDetailWithOrderNo:weakself.orderNo andCallBack:^(id obj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.indicatorView stopAnimating];
        });
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                NSDictionary *dic = obj[@"data"];
                weakself.detailModel = [[OrderDetailModel alloc] initWithDictionary:dic error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.normalOrderDetailView.detailModel = weakself.detailModel;
                    [weakself.normalOrderDetailView layoutIfNeeded];
                });
            }else{
                if (![code isEqualToString:@"39999"]) {
                    NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:mes];
                    });
                }
                
            }
        }
    }];
}

@end
