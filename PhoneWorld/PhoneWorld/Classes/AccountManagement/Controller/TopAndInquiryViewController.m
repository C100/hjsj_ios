//
//  TopAndInquiryViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopAndInquiryViewController.h"
#import "RechargeListModel.h"

typedef enum : NSUInteger {
    refreshing,
    loading
} requestType;

static TopAndInquiryViewController *_topAndInquiryViewController;

@interface TopAndInquiryViewController ()

@property (nonatomic) NSString *accountTel;
@property (nonatomic) int page;
@property (nonatomic) int linage;
@property (nonatomic) NSMutableArray *rechargeListArray;

@end

@implementation TopAndInquiryViewController

+ (TopAndInquiryViewController *)sharedTopAndInquiryViewController{
    if (_topAndInquiryViewController == nil) {
        _topAndInquiryViewController = [[TopAndInquiryViewController alloc] init];
    }
    return _topAndInquiryViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        [self.inquiryView.contentView.orderTwoTableView.mj_header beginRefreshing];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户充值查询";
    self.view.backgroundColor = [UIColor whiteColor];

    self.page = 1;
    self.linage = 10;
    self.rechargeListArray = [NSMutableArray array];
    self.inquiryConditionArray = [NSArray array];
    
    self.inquiryView = [[TopAndInquiryView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.inquiryView];
    
    __block __weak TopAndInquiryViewController *weakself = self;
    
    self.inquiryView.contentView.orderTwoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself requestAllInfosWithType:refreshing];
    }];
    
    self.inquiryView.contentView.orderTwoTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself requestAllInfosWithType:loading];
    }];
    
}

- (void)requestAllInfosWithType:(requestType)type{
    __block __weak TopAndInquiryViewController *weakself = self;

    self.inquiryView.contentView.userInteractionEnabled = NO;
    
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        if (type == refreshing) {
            [weakself.inquiryView.contentView.orderTwoTableView.mj_header endRefreshing];
        }else{
            [weakself.inquiryView.contentView.orderTwoTableView.mj_footer endRefreshing];
        }
        self.inquiryView.contentView.userInteractionEnabled = YES;
    }
    
    NSString *requestString = @"没有数据";
    if (type == refreshing) {
        weakself.rechargeListArray = [NSMutableArray array];
        self.page = 1;
    }else{
        self.page ++;
        requestString = @"已经是最后一页";
    }
    
    NSString *beginDate = @"无";
    NSString *endDate = @"无";
//    NSString *orderState = @"无";
    if (self.inquiryConditionArray.count > 0) {
        beginDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray.firstObject];
        endDate = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[1]];
//        orderState = [NSString stringWithFormat:@"%@",weakself.inquiryConditionArray[2]];//接口未加上
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:@"username"];
    NSString *token = [ud objectForKey:@"session_token"];
    [WebUtils requestPersonalInfoWithSessionToken:token andUserName:username andCallBack:^(id obj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.inquiryView.contentView.userInteractionEnabled = YES;
        });
        if (obj) {
            weakself.accountTel = [NSString stringWithFormat:@"%@",obj[@"data"][@"tel"]];
            
            NSString *pageStr = [NSString stringWithFormat:@"%d",weakself.page];
            NSString *linageStr = [NSString stringWithFormat:@"%d",weakself.linage];
            
            [WebUtils requestRechargeListWithNumber:weakself.accountTel andRechargeType:@"0" andStartTime:beginDate andEndTime:endDate andPage:pageStr andLinage:linageStr andCallBack:^(id obj) {
                if (obj) {
                    NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                    if ([code isEqualToString:@"10000"]) {
                        
                        int count = [NSString stringWithFormat:@"%@",obj[@"data"][@"count"]].intValue;
                        if (count == 0 && type == loading) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [Utils toastview:requestString];
                            });
                        }else{
                            NSArray *orderArr = obj[@"data"][@"order"];
                            for (NSDictionary *dic in orderArr) {
                                RechargeListModel *rm = [[RechargeListModel alloc] initWithDictionary:dic error:nil];
                                [weakself.rechargeListArray addObject:rm];
                            }
                            weakself.inquiryView.contentView.orderListArray = weakself.rechargeListArray;
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                
                                weakself.inquiryView.contentView.resultNumLB.text = [NSString stringWithFormat:@"共%ld条",weakself.rechargeListArray.count];

                                
                                
                                [weakself.inquiryView.contentView.orderTwoTableView reloadData];
                            });
                        }
                        
                    }else{
                        //后台
                        if (![code isEqualToString:@"39999"]) {
                            NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [Utils toastview:mes];
                            });
                        }
                        
                    }
                }
            }];

            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (type == refreshing) {
                    [weakself.inquiryView.contentView.orderTwoTableView.mj_header endRefreshing];
                }else{
                    [weakself.inquiryView.contentView.orderTwoTableView.mj_footer endRefreshing];
                }
            });
            
            
            
        }
    }];
}

@end
