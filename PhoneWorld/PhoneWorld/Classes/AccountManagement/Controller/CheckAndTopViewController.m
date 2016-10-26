//
//  CheckAndTopViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CheckAndTopViewController.h"
#import "CheckAndTopView.h"
#import "TopResultViewController.h"

@interface CheckAndTopViewController ()
@property (nonatomic) CheckAndTopView *checkAndTopView;
@end

@implementation CheckAndTopViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额查询与充值";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"返回";
    [backButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = backButton;
    
    self.checkAndTopView = [[CheckAndTopView alloc] init];
    [self.view addSubview:self.checkAndTopView];
    [self.checkAndTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    __block __weak CheckAndTopViewController *weakself = self;
    
    [self.checkAndTopView setCheckAndTopCallBack:^(NSString *money, payWay payway) {
        NSInteger moneyInt = money.integerValue;
        if (moneyInt == 0) {
            [Utils toastview:@"请输入充值金额"];
        }else{
            if (payway == weixinPay || payway == aliPay) {
                NSLog(@"-------------充值金额%@   充值方式%lu",money,(unsigned long)payway);
                /*--------跳转到充值结果页面--------*/
                TopResultViewController *vc = [TopResultViewController new];
                vc.isSucceed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                [Utils toastview:@"请选择充值方式"];
            }
        }
    }];
}

@end
