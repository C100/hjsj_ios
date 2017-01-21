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

#import "RightItemView.h"

#import "OpenAccomplishCardViewController.h"
#import "OpenWhiteCardViewController.h"
#import "TransferViewController.h"
#import "RepairCardViewController.h"
#import "TopUpViewController.h"


#define selectV 220/375.0

//static OrderViewController *_orderViewController;

@interface OrderViewController ()<UIScrollViewDelegate>

@property (nonatomic) OrderMainView *orderMainView;

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
    
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        
        switch (self.orderMainView.selectedIndex - 10) {
            case 0:
            {
                [OpenAccomplishCardViewController sharedOpenAccomplishCardViewController].orderModelsArr = [NSMutableArray array];
                [[OpenAccomplishCardViewController sharedOpenAccomplishCardViewController].orderView.orderTableView reloadData];
                [[OpenAccomplishCardViewController sharedOpenAccomplishCardViewController].orderView.orderTableView.mj_header beginRefreshing];

            }
                break;
            case 1:
            {
                [OpenWhiteCardViewController sharedOpenWhiteCardViewController].orderModelsArr = [NSMutableArray array];
                [[OpenWhiteCardViewController sharedOpenWhiteCardViewController].orderView.orderTableView reloadData];
                [[OpenWhiteCardViewController sharedOpenWhiteCardViewController].orderView.orderTableView.mj_header beginRefreshing];

            }
                break;
            case 2:
            {
                [TransferViewController sharedTransferViewController].orderModelArr = [NSMutableArray array];
                [[TransferViewController sharedTransferViewController].orderView.orderTableView reloadData];
                [[TransferViewController sharedTransferViewController].orderView.orderTableView.mj_header beginRefreshing];
            }
                break;
            case 3:
            {
                [RepairCardViewController sharedRepairCardViewController].cardRepairList = [NSMutableArray array];
                [[RepairCardViewController sharedRepairCardViewController].orderView.orderTableView reloadData];
                [[RepairCardViewController sharedRepairCardViewController].orderView.orderTableView.mj_header beginRefreshing];
            }
                break;
            case 4:
            {
                [TopUpViewController sharedTopUpViewController].rechargeListArray = [NSMutableArray array];
                [[TopUpViewController sharedTopUpViewController].orderTwoView.orderTwoTableView reloadData];
                [[TopUpViewController sharedTopUpViewController].orderTwoView.orderTwoTableView.mj_header beginRefreshing];
            }
                break;
        }
        
        //如果有网刷新成卡开户的，别的界面点击的时候再刷新
    }
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
    
    self.orderMainView = [[OrderMainView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.orderMainView];
    [self.orderMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

@end
