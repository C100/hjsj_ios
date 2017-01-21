//
//  CardInquiryViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/20.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardInquiryViewController.h"
#import "CardTransferListModel.h"
#import "TransferDetailViewController.h"
#import "RepairCardDetailViewController.h"

typedef enum : NSUInteger {
    refreshing,
    loading
} requestType;

static CardInquiryViewController *_cardInquiryViewController;

@interface CardInquiryViewController ()

@property (nonatomic) int page;
@property (nonatomic) int linage;
@property (nonatomic) NSMutableArray *listArray;

@end

@implementation CardInquiryViewController

+ (CardInquiryViewController *)sharedCardInquiryViewController{
    if (_cardInquiryViewController == nil) {
        _cardInquiryViewController = [[CardInquiryViewController alloc] init];
    }
    return _cardInquiryViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if([[AFNetworkReachabilityManager sharedManager] isReachable]){
        [self.inquiryView.contentView.orderTableView.mj_header beginRefreshing];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"过户、补卡状态查询";
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    self.page = 1;
    self.linage = 10;
    self.listArray = [NSMutableArray array];
    self.stateCode = @"无";//审核
    
    self.inquiryView = [[CardInquiryView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.inquiryView];
    
    __block __weak CardInquiryViewController *weakself = self;
    
    [self.inquiryView.contentView setOrderViewCallBack:^(NSInteger section) {
        //过户和补卡返回的list字段一致
        CardTransferListModel *listModel = weakself.listArray[section];
        if ([listModel.state isEqualToString:@"过户"]) {
            TransferDetailViewController *vc = [TransferDetailViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.listModel = listModel;
            vc.modelId = listModel.order_id;
            [weakself.navigationController pushViewController:vc animated:YES];
        }else{//补卡
            RepairCardDetailViewController *vc = [RepairCardDetailViewController new];
            vc.cardModel = listModel;
            vc.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    
    self.inquiryView.contentView.orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself requestAllInfosWithType:refreshing];
    }];
    
    self.inquiryView.contentView.orderTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself requestAllInfosWithType:loading];
    }];
    
}

- (void)requestAllInfosWithType:(requestType)type{
    
    self.view.userInteractionEnabled = NO;
    
    __block __weak CardInquiryViewController *weakself = self;
    
    if(![[AFNetworkReachabilityManager sharedManager] isReachable]){
        if (type == refreshing) {
            [weakself.inquiryView.contentView.orderTableView.mj_header endRefreshing];
        }else{
            [weakself.inquiryView.contentView.orderTableView.mj_footer endRefreshing];
        }
        self.view.userInteractionEnabled = YES;

    }
    
    NSString *requestString = @"没有数据";
    if (type == refreshing) {
        self.page = 1;
        self.listArray = [NSMutableArray array];
    }else{
        self.page ++;
        requestString = @"已经是最后一页";
    }
    
    NSString *beginDate = @"无";
    NSString *endDate = @"无";
    NSString *phoneNumber = @"无";
    NSString *orderState = @"0";//补卡  过户
    
    NSString *state = @"过户";
    
    if (self.inquiryConditionArray.count > 0) {
        beginDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray.firstObject];
        endDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[1]];
        phoneNumber = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray.lastObject];
        NSString *stateGet = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[2]];//补卡 过户
        
        if ([stateGet isEqualToString:@"补卡"]) {
            orderState = @"1";
            state = @"补卡";
        }else{
            orderState = @"0";
        }
    }
    
    if ([self.stateCode isEqualToString:@"待审核"]) {
        self.stateCode = @"1";
    }
    if ([self.stateCode isEqualToString:@"审核通过"]) {
        self.stateCode = @"2";
    }
    if ([self.stateCode isEqualToString:@"审核不通过"]) {
        self.stateCode = @"3";
    }
    if ([self.stateCode isEqualToString:@"全部"]) {
        self.stateCode = @"无";
    }
    
    NSString *pageStr = [NSString stringWithFormat:@"%d",self.page];
    NSString *linageStr = [NSString stringWithFormat:@"%d",self.linage];
    
    [WebUtils requestCardTransferListWithNumber:phoneNumber andType:orderState andStartTime:beginDate andEndTime:endDate andStartCode:weakself.stateCode andStartName:orderState andPage:pageStr andLinage:linageStr andCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                
                int count = [NSString stringWithFormat:@"%@",obj[@"data"][@"count"]].intValue;
                if (count == 0) {
                    if (type == loading) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:requestString];
                        });
                    }
                    
                }else{
                    NSArray *orderArr = obj[@"data"][@"order"];
                    for (NSDictionary *dic in orderArr) {
                        CardTransferListModel *rm = [[CardTransferListModel alloc] initWithDictionary:dic error:nil];
                        rm.state = state;
                        [weakself.listArray addObject:rm];
                    }
                    
                }
                
                weakself.inquiryView.contentView.orderListArray = weakself.listArray;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    weakself.inquiryView.contentView.resultNumLB.text = [NSString stringWithFormat:@"共%ld条",weakself.listArray.count];
                    
                    [weakself.inquiryView.contentView.orderTableView reloadData];
                    weakself.view.userInteractionEnabled = YES;
                    
                });
                
            }else{
                //后台
                if (![code isEqualToString:@"39999"]) {
                    NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:mes];
                        weakself.view.userInteractionEnabled = YES;
                        
                    });
                }
                
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (type == refreshing) {
                [weakself.inquiryView.contentView.orderTableView.mj_header endRefreshing];
            }else{
                [weakself.inquiryView.contentView.orderTableView.mj_footer endRefreshing];
            }
        });
        
    }];
    
}

@end
