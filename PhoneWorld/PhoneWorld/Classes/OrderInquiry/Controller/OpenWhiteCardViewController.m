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

#import "OrderListModel.h"

static OpenWhiteCardViewController *_openWhiteCardViewController;

typedef enum : NSUInteger {
    refreshing,
    loading
} requestType;

@interface OpenWhiteCardViewController ()

@property (nonatomic) int page;
@property (nonatomic) int linage;

@end

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
    
    self.page = 1;
    self.linage = 10;
    self.orderModelsArr = [NSMutableArray array];
    
    __block __weak OpenWhiteCardViewController *weakself = self;
    [self.orderView setOrderViewCallBack:^(NSInteger section) {
        //成卡开户  跳转  订单信息
        OrderListModel *orderModel = weakself.orderModelsArr[section];
        
        NormalOrderDetailViewController *vc = [NormalOrderDetailViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.orderNo = orderModel.orderNo;
        vc.orderModel = orderModel;
        [[OrderViewController shareOrderViewController].navigationController pushViewController:vc animated:YES];
    }];
    
    self.orderView.orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself requestOrderListWithType:refreshing];
    }];
    
    self.orderView.orderTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself requestOrderListWithType:loading];
    }];
    
//    [self.orderView.orderTableView.mj_header beginRefreshing];
}

- (void)requestOrderListWithType:(requestType)requestType{
    __block __weak OpenWhiteCardViewController *weakself = self;
    
    self.orderView.userInteractionEnabled = NO;
    
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        if (requestType == refreshing) {
            [weakself.orderView.orderTableView.mj_header endRefreshing];
        }else{
            [weakself.orderView.orderTableView.mj_footer endRefreshing];
        }
        self.orderView.userInteractionEnabled = YES;
        return;
    }
    
    NSString *requestString = @"没有数据";

    if (requestType == refreshing) {
        self.page = 1;
        self.orderModelsArr = [NSMutableArray array];

    }else if(requestType == loading){
        self.page ++;
        requestString = @"已经是最后一页";
    }
    
    NSString *phoneNumber = @"无";
    NSString *beginDate = @"无";
    NSString *endDate = @"无";
    NSString *orderState = @"无";
    NSString *orderStatusCode = @"无";

    if (self.inquiryConditionArray.count > 0) {
        phoneNumber = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray.lastObject];
        beginDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray.firstObject];
        endDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[1]];
        orderState = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[2]];
    }
    NSString *pageStr = [NSString stringWithFormat:@"%d",self.page];
    NSString *linageStr = [NSString stringWithFormat:@"%d",self.linage];
    
    if ([orderState isEqualToString:@"已提交"]) {
        orderStatusCode = @"PENDING";
    }
    if ([orderState isEqualToString:@"等待中"]) {
        orderStatusCode = @"WAITING";
    }
    if ([orderState isEqualToString:@"成功"]) {
        orderStatusCode = @"SUCCESS";
    }
    if ([orderState isEqualToString:@"失败"]) {
        orderStatusCode = @"FAIL";
    }
    if ([orderState isEqualToString:@"已取消"]) {
        orderStatusCode = @"CANCEL";
    }
    
    [WebUtils requestInquiryOrderListWithPhoneNumber:phoneNumber andType:@"ESIM" andStartTime:beginDate andEndTime:endDate andOrderStatusCode:orderStatusCode andOrderStatusName:orderState andPage:pageStr andLinage:linageStr andCallBack:^(id obj) {
        if (obj) {
            
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                int count = [NSString stringWithFormat:@"%@",obj[@"data"][@"count"]].intValue;
                if (count == 0) {
                    if (requestType == refreshing) {
                        weakself.orderView.orderListArray = nil;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [Utils toastview:requestString];
                        if (requestType == loading) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [Utils toastview:requestString];
                            });
                        }
                        weakself.orderView.resultNumLB.text = [NSString stringWithFormat:@"共%ld条",weakself.orderModelsArr.count];
                        
                        [weakself.orderView.orderTableView reloadData];
                        weakself.orderView.userInteractionEnabled = YES;
                    });
                }else{
                    NSArray *arr = obj[@"data"][@"order"];
                    for (NSDictionary *dic in arr) {
                        OrderListModel *om = [[OrderListModel alloc] initWithDictionary:dic error:nil];
                        [weakself.orderModelsArr addObject:om];
                    }
                    weakself.orderView.orderListArray = weakself.orderModelsArr;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.orderView.resultNumLB.text = [NSString stringWithFormat:@"共%ld条",weakself.orderModelsArr.count];

                        [weakself.orderView.orderTableView reloadData];
                        weakself.orderView.userInteractionEnabled = YES;

                    });
                }
            }else{
                if (![code isEqualToString:@"39999"]) {
                    NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:mes];
                        weakself.orderView.userInteractionEnabled = YES;
                        
                    });
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (requestType == refreshing) {
                    [weakself.orderView.orderTableView.mj_header endRefreshing];
                }else{
                    [weakself.orderView.orderTableView.mj_footer endRefreshing];
                }
            });
            
        }
    }];
}

@end
