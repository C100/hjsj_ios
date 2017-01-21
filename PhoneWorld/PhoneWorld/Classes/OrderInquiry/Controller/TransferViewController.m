//
//  TransferViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TransferViewController.h"
#import "OrderView.h"
#import "TransferDetailViewController.h"
#import "OrderViewController.h"

#import "CardTransferListModel.h"

static TransferViewController *_transferViewController;

typedef enum : NSUInteger {
    refreshing,
    loading
} requestType;

@interface TransferViewController ()

@property (nonatomic) int page;
@property (nonatomic) int linage;

@end

@implementation TransferViewController

+ (TransferViewController *)sharedTransferViewController{
    if (_transferViewController == nil) {
        _transferViewController = [[TransferViewController alloc] init];
    }
    return _transferViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.page = 1;
    self.linage = 10;
    
    self.orderModelArr = [NSMutableArray array];
    
    self.orderView = [[OrderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80)];
    [self.view addSubview:self.orderView];
    
    __block __weak TransferViewController *weakself = self;

    [self.orderView setOrderViewCallBack:^(NSInteger section) {
        
        CardTransferListModel *listModel = weakself.orderModelArr[section];
        
        TransferDetailViewController *vc = [TransferDetailViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.listModel = listModel;
        vc.modelId = listModel.order_id;
        [[OrderViewController shareOrderViewController].navigationController pushViewController:vc animated:YES];
    }];
    
    self.orderView.orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself requestOrderListWithType:refreshing];
    }];
    
    self.orderView.orderTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself requestOrderListWithType:loading];
    }];
}

- (void)requestOrderListWithType:(requestType)requestType{
    
    __block __weak TransferViewController *weakself = self;
    
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
        self.orderModelArr = [NSMutableArray array];
    }else{
        self.page ++;
        requestString = @"已经是最后一页";
    }
    
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
    
    NSString *stateCode = @"无";
    
    if ([orderState isEqualToString:@"待审核"]) {
        stateCode = @"1";
    }
    if ([orderState isEqualToString:@"审核通过"]) {
        stateCode = @"2";
    }
    if ([orderState isEqualToString:@"审核不通过"]) {
        stateCode = @"3";
    }
    
    if ([orderState isEqualToString:@"全部"]) {
        orderState = @"无";
    }
    
    [WebUtils requestCardTransferListWithNumber:phoneNumber andType:@"0" andStartTime:beginDate andEndTime:endDate andStartCode:stateCode andStartName:orderState andPage:pageStr andLinage:linageStr andCallBack:^(id obj) {
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
                        weakself.orderView.resultNumLB.text = [NSString stringWithFormat:@"共%ld条",weakself.orderModelArr.count];
                        
                        [weakself.orderView.orderTableView reloadData];
                        weakself.orderView.userInteractionEnabled = YES;
                    });
                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [Utils toastview:requestString];
//                        weakself.orderView.userInteractionEnabled = YES;
//
//                    });
                }else{
                    NSArray *arr = obj[@"data"][@"order"];
                    for (NSDictionary *dic in arr) {
                        
                        CardTransferListModel *model = [[CardTransferListModel alloc] initWithDictionary:dic error:nil];
                        [weakself.orderModelArr addObject:model];
                    }
                    weakself.orderView.orderListArray = weakself.orderModelArr;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.orderView.resultNumLB.text = [NSString stringWithFormat:@"共%ld条",weakself.orderModelArr.count];

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
