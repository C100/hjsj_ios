//
//  TopUpViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopUpViewController.h"

static TopUpViewController *_topUpViewController;

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
    self.orderTwoView = [[OrderTwoView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80)];
    [self.view addSubview:self.orderTwoView];
    
    [self.orderTwoView.orderTwoTableView addPullToRefreshWithActionHandler:^{
        //下拉刷新
    }];
    
    [self.orderTwoView.orderTwoTableView addInfiniteScrollingWithActionHandler:^{
        //上拉加载
    }];
    
    [self.orderTwoView.orderTwoTableView.pullToRefreshView stopAnimating];
    [self.orderTwoView.orderTwoTableView.infiniteScrollingView stopAnimating];
    
}

@end
