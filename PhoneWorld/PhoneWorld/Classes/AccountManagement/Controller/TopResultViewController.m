//
//  TopSucceedViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopResultViewController.h"
#import "TopResultView.h"

@interface TopResultViewController ()
@property (nonatomic) TopResultView *topResultView;
@end

@implementation TopResultViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付结果";
    [self.navigationItem setHidesBackButton:YES];

    self.topResultView = [[TopResultView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andIsSucceed:self.isSucceed];
    [self.view addSubview:self.topResultView];
    self.topResultView.allResults = self.allResults;
}

@end
