//
//  TopCallMoneyViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopCallMoneyViewController.h"
#import "TopCallMoneyView.h"
#import "PayView.h"

@interface TopCallMoneyViewController ()
@property (nonatomic) TopCallMoneyView *topCallMoneyView;
@end

@implementation TopCallMoneyViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"话费充值";

    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.topCallMoneyView = [[TopCallMoneyView alloc] init];
    [self.view addSubview:self.topCallMoneyView];
    [self.topCallMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.topCallMoneyView setTopCallMoneyCallBack:^(NSInteger money, NSString *phone) {
        NSLog(@"----------%ld--------%@",money,phone);
    }];
}

@end
