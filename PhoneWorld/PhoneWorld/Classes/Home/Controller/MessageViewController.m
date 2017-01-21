//
//  MessageViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageView.h"
#import "MessageModel.h"

typedef enum : NSUInteger {
    refreshing,
    loading
} requestType;

@interface MessageViewController ()

@property (nonatomic) NSInteger linage;
@property (nonatomic) NSInteger page;
@property (nonatomic) MessageView *messageView;
@property (nonatomic) NSMutableArray *messageArray;

@end

@implementation MessageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息中心";
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    self.linage = (screenHeight-64)/40;
    self.page = 1;
    
    self.messageView = [[MessageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.messageView];
    
    __block __weak MessageViewController *weakself = self;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"readNotification" object:nil];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:@"isClickedNewsCenter"];
    [ud synchronize];
    
    self.messageView.messageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself requestWithType:refreshing];
    }];
    
    self.messageView.messageTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself requestWithType:loading];
    }];
    
    [self.messageView.messageTableView.mj_header beginRefreshing];
}

- (void)requestWithType:(requestType)type{
    __block __weak MessageViewController *weakself = self;
    NSString *requestString = @"没有数据";
    if (type == refreshing) {
        self.page = 1;
        self.messageArray = [NSMutableArray array];
    }else{
        self.page ++;
        requestString = @"已经是最后一页了";
    }
    
    NSString *linageStr = [NSString stringWithFormat:@"%ld",self.linage];
    NSString *pageStr = [NSString stringWithFormat:@"%ld",self.page];
    
    if([[AFNetworkReachabilityManager sharedManager] isReachable] == NO){
        if (type == loading) {
            [self.messageView.messageTableView.mj_footer endRefreshing];
        }else{
            [self.messageView.messageTableView.mj_header endRefreshing];
        }
    }
    
    [WebUtils requestMessageListWithLinage:linageStr andPage:pageStr andCallBack:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
        if(obj){
            if([code isEqualToString:@"10000"]){
                //正确
                int count = [obj[@"data"][@"count"] intValue];
                
                if (count == 0) {
                    if (type == loading) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:requestString];
                        });
                    }
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSArray *messageArr = obj[@"data"][@"notice"];
                        for (NSDictionary *dic in messageArr) {
                            MessageModel *mm = [[MessageModel alloc] initWithDictionary:dic error:nil];
                            [weakself.messageArray addObject:mm];
                        }
                        weakself.messageView.messagesArray = weakself.messageArray;
                        
                        [weakself.messageView.messageTableView reloadData];
                    });
                }
            }else{
                //查询错误
                NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [Utils toastview:mes];
                });
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (type == refreshing) {
                [weakself.messageView.messageTableView.mj_header endRefreshing];
            }else{
                [weakself.messageView.messageTableView.mj_footer endRefreshing];
            }
        });
    }];
}

@end
