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

static TransferViewController *_transferViewController;

@interface TransferViewController ()
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
    self.orderView = [[OrderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80 - 20)];
    [self.view addSubview:self.orderView];
    [self.orderView setOrderViewCallBack:^(NSInteger section) {
        TransferDetailViewController *vc = [TransferDetailViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [[OrderViewController shareOrderViewController].navigationController pushViewController:vc animated:YES];
    }];
}

@end
