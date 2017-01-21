//
//  ChannelPartnersManageViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChannelPartnersManageViewController.h"

#import "RightItemView.h"

#import "ChannelModel.h"
#import "OrderCountModel.h"

typedef enum : NSUInteger {
    refreshing,
    loading
} requestType;

static ChannelPartnersManageViewController *_channelPartnersManageViewController;

@interface ChannelPartnersManageViewController ()

@property (nonatomic) int pageChannel;
@property (nonatomic) int linageChannel;
@property (nonatomic) NSMutableArray<ChannelModel *> *channelArray;

@property (nonatomic) int pageOrder;
@property (nonatomic) int linageOrder;
@property (nonatomic) NSMutableArray<OrderCountModel *> *orderArray;

@end

@implementation ChannelPartnersManageViewController

+ (ChannelPartnersManageViewController *)sharedChannelPartnersManageViewController{
    if (_channelPartnersManageViewController == nil) {
        _channelPartnersManageViewController = [[ChannelPartnersManageViewController alloc] init];
    }
    return _channelPartnersManageViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        [self.channelView.channelPartnersTableView.mj_header beginRefreshing];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"渠道商管理";

    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.channelView = [[ChannelPartnersManageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108)];
    [self.view addSubview:self.channelView];
    
    self.pageChannel = 1;
    self.pageOrder = 1;
    self.linageOrder = 10;
    self.linageChannel = 10;
    self.orderArray = [NSMutableArray array];
    self.channelArray = [NSMutableArray array];
    
    self.conditions = @{@"手机号码":@"无",@"时间":@"无"};
    
    self.channelView.channelPartnersTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestChannelListWithType:refreshing];
    }];
    
    self.channelView.channelPartnersTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestChannelListWithType:loading];
    }];
    
    self.channelView.orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestOrderListWithType:refreshing];
    }];
    
    self.channelView.orderTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestOrderListWithType:loading];
    }];
    
}

//渠道商列表
- (void)requestChannelListWithType:(requestType)type{
    __block __weak ChannelPartnersManageViewController *weakself = self;
    self.channelView.channelPartnersTableView.userInteractionEnabled = NO;
    NSString *requestString = @"已经是最后一页了";
    if (type == refreshing) {
        self.channelArray = [NSMutableArray array];
        requestString = @"没有数据";
        self.pageChannel = 1;
    }else{
        self.pageChannel ++;
    }
    
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        weakself.channelView.channelPartnersTableView.userInteractionEnabled = YES;
        if (type == refreshing) {
            [weakself.channelView.channelPartnersTableView.mj_header endRefreshing];
        }else{
            [weakself.channelView.channelPartnersTableView.mj_footer endRefreshing];
        }
    }
    
    [WebUtils requestChannelListWithPage:self.pageChannel andLinage:self.linageChannel andCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                int count = [[NSString stringWithFormat:@"%@",obj[@"data"][@"count"]] intValue];
                if (count == 0 && type == loading) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:requestString];
                    });
                    
                }else{
                    NSArray *arr = obj[@"data"][@"channels"];

                    for (NSDictionary *dic in arr) {
                        ChannelModel *channelModel = [[ChannelModel alloc] initWithDictionary:dic error:nil];
                        [weakself.channelArray addObject:channelModel];
                    }
                    weakself.channelView.channelArray = weakself.channelArray;

                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.channelView.channelNumberLB.text = [NSString stringWithFormat:@"共%ld条",weakself.channelArray.count];
                        [weakself.channelView.channelPartnersTableView reloadData];
                    });
                }
                
            }else{
                if (![code isEqualToString:@"39999"]) {
                    NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:mes];
                    });
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (type == refreshing) {
                weakself.channelView.channelPartnersTableView.userInteractionEnabled = YES;
                [weakself.channelView.channelPartnersTableView.mj_header endRefreshing];
            }else{
                weakself.channelView.channelPartnersTableView.userInteractionEnabled = YES;
                [weakself.channelView.channelPartnersTableView.mj_footer endRefreshing];
            }
        });
    }];
}

//订单记录
- (void)requestOrderListWithType:(requestType)type{
    __block __weak ChannelPartnersManageViewController *weakself = self;
    NSString *requestString = @"已经是最后一页了";
    if (type == refreshing) {
        requestString = @"没有数据";
        self.pageOrder = 1;
        self.orderArray = [NSMutableArray array];
    }else{
        self.pageOrder ++;
    }
    self.channelView.orderTableView.userInteractionEnabled = NO;
    
    NSString *orgCode = [NSString stringWithFormat:@"%@",[self.conditions objectForKey:@"工号"]];
    NSString *monthCount = [NSString stringWithFormat:@"%@",[self.conditions objectForKey:@"时间"]];
    
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        weakself.channelView.orderTableView.userInteractionEnabled = YES;
        if (type == refreshing) {
            [weakself.channelView.orderTableView.mj_header endRefreshing];
        }else{
            [weakself.channelView.orderTableView.mj_footer endRefreshing];
        }
    }
    
    if ([monthCount isEqualToString:@"一个月"]) {
        monthCount = @"1";
    }
    
    if ([monthCount isEqualToString:@"二个月"]) {
        monthCount = @"2";
    }
    
    if ([monthCount isEqualToString:@"三个月"]) {
        monthCount = @"3";
    }
    
    if ([monthCount isEqualToString:@"四个月"]) {
        monthCount = @"4";
    }
    
    if ([monthCount isEqualToString:@"五个月"]) {
        monthCount = @"5";
    }
    
    if ([monthCount isEqualToString:@"六个月"]) {
        monthCount = @"6";
    }
    
    [WebUtils requestOrderListWithOrgCode:orgCode andMonthCount:monthCount andPage:self.pageOrder andLinage:self.linageOrder andCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                int count = [[NSString stringWithFormat:@"%@",obj[@"data"][@"count"]] intValue];
                if (count == 0 && type == loading) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:requestString];
                    });
                }else{
                    NSArray *arr = obj[@"data"][@"channelsOpenCount"];
                    for (NSDictionary *dic in arr) {
                        OrderCountModel *orderModel = [[OrderCountModel alloc] initWithDictionary:dic error:nil];
                        [weakself.orderArray addObject:orderModel];
                    }
                    weakself.channelView.orderArray = weakself.orderArray;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.channelView.orderNumberLB.text = [NSString stringWithFormat:@"共%ld条",weakself.orderArray.count];
                        [weakself.channelView.orderTableView reloadData];
                    });
                }
            }else{
                if (![code isEqualToString:@"39999"]) {
                    NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:mes];
                    });
                }
                
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (type == refreshing) {
                self.channelView.orderTableView.userInteractionEnabled = YES;
                [weakself.channelView.orderTableView.mj_header endRefreshing];
            }else{
                self.channelView.orderTableView.userInteractionEnabled = YES;
                [weakself.channelView.orderTableView.mj_footer endRefreshing];
            }
        });
    }];
}

@end
