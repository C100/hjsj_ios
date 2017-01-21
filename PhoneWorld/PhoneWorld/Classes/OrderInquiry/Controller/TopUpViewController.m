//
//  TopUpViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopUpViewController.h"
#import "RechargeListModel.h"

static TopUpViewController *_topUpViewController;

typedef enum : NSUInteger {
    refreshing,
    loading
} requestType;

@interface TopUpViewController ()

@property (nonatomic) int page;
@property (nonatomic) int linage;

@end

@implementation TopUpViewController

+ (TopUpViewController *)sharedTopUpViewController{
    if (_topUpViewController == nil) {
        _topUpViewController = [[TopUpViewController alloc] init];
    }
    return _topUpViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.page = 1;
    self.linage = 10;
    
    self.rechargeListArray = [NSMutableArray array];
    
    self.orderTwoView = [[OrderTwoView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80)];
    [self.view addSubview:self.orderTwoView];
    
    __block __weak TopUpViewController *weakself = self;

    self.orderTwoView.orderTwoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself requestOrderListWithType:refreshing];
    }];
    
    self.orderTwoView.orderTwoTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself requestOrderListWithType:loading];
    }];
    
//    [self.orderTwoView.orderTwoTableView.mj_header beginRefreshing];
}

- (void)requestOrderListWithType:(requestType)requestType{
    
    self.orderTwoView.userInteractionEnabled = NO;
    
    __block __weak TopUpViewController *weakself = self;
    
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        if (requestType == refreshing) {
            [weakself.orderTwoView.orderTwoTableView.mj_header endRefreshing];
        }else{
            [weakself.orderTwoView.orderTwoTableView.mj_footer endRefreshing];
        }
        self.orderTwoView.userInteractionEnabled = YES;
        return;
    }
    
    NSString *requestString = @"没有数据";
    if (requestType == refreshing) {
        self.page = 1;
        self.rechargeListArray = [NSMutableArray array];
    }else{
        self.page ++;
        requestString = @"已经是最后一页";
    }
    
    NSString *phoneNumber = @"无";
    NSString *beginDate = @"无";
    NSString *endDate = @"无";
//    NSString *orderState = @"无";
    if (self.inquiryConditionArray.count > 0) {
        phoneNumber = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray.lastObject];
        beginDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray.firstObject];
        endDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[1]];
//        orderState = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[2]];//这个暂时用不到
    }
    NSString *pageStr = [NSString stringWithFormat:@"%d",self.page];
    NSString *linageStr = [NSString stringWithFormat:@"%d",self.linage];
    
    [WebUtils requestRechargeListWithNumber:phoneNumber andRechargeType:@"1" andStartTime:beginDate andEndTime:endDate andPage:pageStr andLinage:linageStr andCallBack:^(id obj) {
        if (obj) {
            
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                
                int count = [NSString stringWithFormat:@"%@",obj[@"data"][@"count"]].intValue;
                if (count == 0) {                    
                    if (requestType == refreshing) {
                        weakself.rechargeListArray = nil;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (requestType == loading) {
                            [Utils toastview:requestString];
                        }
//                        [Utils toastview:requestString];
                        weakself.orderTwoView.resultNumLB.text = [NSString stringWithFormat:@"共%ld条",weakself.rechargeListArray.count];
                        weakself.orderTwoView.orderListArray = weakself.rechargeListArray;

                        [weakself.orderTwoView.orderTwoTableView reloadData];
                        weakself.orderTwoView.userInteractionEnabled = YES;
                    });
                    
                }else{
                    NSArray *orderArr = obj[@"data"][@"order"];
                    for (NSDictionary *dic in orderArr) {
                        RechargeListModel *rm = [[RechargeListModel alloc] initWithDictionary:dic error:nil];
                        [weakself.rechargeListArray addObject:rm];
                    }
                    weakself.orderTwoView.orderListArray = weakself.rechargeListArray;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakself.orderTwoView.orderTwoTableView reloadData];
                        weakself.orderTwoView.resultNumLB.text = [NSString stringWithFormat:@"共%ld条",weakself.rechargeListArray.count];
                        weakself.orderTwoView.userInteractionEnabled = YES;

                    });
                }
                
            }else{
                if (![code isEqualToString:@"39999"]) {
                    NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:mes];
                        weakself.orderTwoView.userInteractionEnabled = YES;
                    });
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (requestType == refreshing) {
                    [weakself.orderTwoView.orderTwoTableView.mj_header endRefreshing];
                }else{
                    [weakself.orderTwoView.orderTwoTableView.mj_footer endRefreshing];
                }
            });
        }
    }];
}

@end
