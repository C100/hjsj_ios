//
//  RepairCardDetailViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RepairCardDetailViewController.h"
#import "RepairCardDetailView.h"

@interface RepairCardDetailViewController ()
@property (nonatomic) RepairCardDetailView *detailView;
@end

@implementation RepairCardDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    self.detailView = [[RepairCardDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.detailView];
}

@end
