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

static OpenAccomplishCardViewController *_openAccomplishCardViewController;

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
    
    [self.orderView setOrderViewCallBack:^(NSInteger section) {
       //成卡开户  跳转  订单信息
        NormalOrderDetailViewController *vc = [NormalOrderDetailViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [[OrderViewController shareOrderViewController].navigationController pushViewController:vc animated:YES];
    }];
}

@end
