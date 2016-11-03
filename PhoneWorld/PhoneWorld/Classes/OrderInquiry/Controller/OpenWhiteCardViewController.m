//
//  OpenWhiteCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OpenWhiteCardViewController.h"
#import "NormalOrderDetailViewController.h"
#import "OrderViewController.h"

static OpenWhiteCardViewController *_openWhiteCardViewController;

@implementation OpenWhiteCardViewController

+ (OpenWhiteCardViewController *)sharedOpenWhiteCardViewController{
    if (_openWhiteCardViewController == nil) {
        _openWhiteCardViewController = [[OpenWhiteCardViewController alloc] init];
    }
    return _openWhiteCardViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.orderView = [[OrderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80)];
    [self.view addSubview:self.orderView];
    
//    __block __weak OpenWhiteCardViewController *weakself = self;
    [self.orderView setOrderViewCallBack:^(NSInteger section) {
        //成卡开户  跳转  订单信息
        NormalOrderDetailViewController *vc = [NormalOrderDetailViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [[OrderViewController shareOrderViewController].navigationController pushViewController:vc animated:YES];
    }];
    
    [self.orderView.orderTableView addPullToRefreshWithActionHandler:^{
        //下拉刷新
    }];
    
    [self.orderView.orderTableView addInfiniteScrollingWithActionHandler:^{
        //上拉加载
    }];
    
    [self.orderView.orderTableView.pullToRefreshView stopAnimating];
    [self.orderView.orderTableView.infiniteScrollingView stopAnimating];
    
}

@end
