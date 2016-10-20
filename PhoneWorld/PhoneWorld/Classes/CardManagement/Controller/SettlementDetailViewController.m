//
//  SettlementDetailViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "SettlementDetailViewController.h"
#import "SettlementDetailView.h"

@interface SettlementDetailViewController ()
@property (nonatomic) SettlementDetailView *detailView;
@end

@implementation SettlementDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算明细";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];

    self.detailView = [[SettlementDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andUserinfos:self.userinfosDic];
    [self.view addSubview:self.detailView];
}

- (void)cancelAction{
    /*
     不保存信息并返回首页
     */
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
