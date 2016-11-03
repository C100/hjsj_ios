//
//  OpenAccomplishCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OpenAccomplishCardViewController.h"
#import "NormalOrderDetailViewController.h"
#import "OrderViewController.h"
#import "NaviViewController.h"
#import <AFNetworkReachabilityManager.h>

static OpenAccomplishCardViewController *_openAccomplishCardViewController;


@interface OpenAccomplishCardViewController ()

@property (nonatomic) AFNetworkReachabilityManager *manager;
@property (nonatomic) int page;
@property (nonatomic) int linage;

@end

@implementation OpenAccomplishCardViewController

+ (OpenAccomplishCardViewController *)sharedOpenAccomplishCardViewController{
    if (_openAccomplishCardViewController == nil) {
        _openAccomplishCardViewController = [[OpenAccomplishCardViewController alloc] init];
    }
    return _openAccomplishCardViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.orderView = [[OrderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80)];
    [self.view addSubview:self.orderView];
    
    self.page = 1;
    self.linage = 10;
    
    [self.orderView setOrderViewCallBack:^(NSInteger section) {
       //成卡开户  跳转  订单信息
        NormalOrderDetailViewController *vc = [NormalOrderDetailViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [[OrderViewController shareOrderViewController].navigationController pushViewController:vc animated:YES];
    }];
    
    __block __weak OpenAccomplishCardViewController *weakself = self;

    
    [self.orderView.orderTableView addPullToRefreshWithActionHandler:^{
        //下拉刷新
        [weakself requestOrderList];
    }];
    
    [self.orderView.orderTableView addInfiniteScrollingWithActionHandler:^{
        //上拉加载
    }];
    
    if (self.manager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self.orderView.orderTableView.pullToRefreshView stopAnimating];
    }
    [self.orderView.orderTableView triggerPullToRefresh];
    
//    [self.orderView.orderTableView.pullToRefreshView stopAnimating];
//    [self.orderView.orderTableView.infiniteScrollingView stopAnimating];
    
}

- (void)requestOrderList{
    __block __weak OpenAccomplishCardViewController *weakself = self;
    NSString *phoneNumber = @"无";
    NSString *beginDate = @"无";
    NSString *endDate = @"无";
    NSString *orderState = @"无";
    if (self.inquiryConditionArray.count > 0) {
        phoneNumber = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray.lastObject];
        beginDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray.firstObject];
        endDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[1]];
        orderState = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[2]];
    }
    NSString *pageStr = [NSString stringWithFormat:@"%d",self.page];
    NSString *linageStr = [NSString stringWithFormat:@"%d",self.linage];
    
    [WebUtils requestInquiryOrderListWithPhoneNumber:phoneNumber andType:@"SIM" andStartTime:beginDate andEndTime:endDate andOrderStatusCode:@"无" andOrderStatusName:orderState andPage:pageStr andLinage:linageStr andCallBack:^(id obj) {
        if (obj) {
            
            
            
            [weakself.orderView.orderTableView.pullToRefreshView stopAnimating];
        }
    }];
}

- (void)requestOrderListMore{
    
}

@end
