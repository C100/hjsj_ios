//
//  OrderViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderViewController.h"
#import "MessageViewController.h"
#import "PersonalHomeViewController.h"
#import "OrderMainView.h"
#import <AFNetworkReachabilityManager.h>

#define selectV 220/375.0

static OrderViewController *_orderViewController;

@interface OrderViewController ()<UIScrollViewDelegate>

@property (nonatomic) OrderMainView *orderMainView;
@property (nonatomic) AFNetworkReachabilityManager *manager;

@end

@implementation OrderViewController
#pragma mark - LifeCircle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.manager = [AFNetworkReachabilityManager manager];
    [self.manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch ((int)status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //无识别网络
                NSLog(@"无识别网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //无网络
                NSLog(@"无网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //流量
                NSLog(@"流量环境");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //wifi下
                NSLog(@"使用Wi-Fi情况下");
            }
                break;
        }
    }];
    [self.manager startMonitoring];//开始监测
}

+ (OrderViewController *)shareOrderViewController{
    if (!_orderViewController) {
        _orderViewController = [[OrderViewController alloc] init];
    }
    return _orderViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"individualCenter"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoPersonalHomeVC)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"news_white"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMessagesVC)];
    
    self.orderMainView = [[OrderMainView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.orderMainView];
    [self.orderMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - Method
- (void)gotoMessagesVC{
    MessageViewController *messageVC = [MessageViewController new];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)gotoPersonalHomeVC{
    PersonalHomeViewController *vc = [PersonalHomeViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
