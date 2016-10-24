//
//  TopAndInquiryViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopAndInquiryViewController.h"
#import "TopAndInquiryView.h"

@interface TopAndInquiryViewController ()

@property (nonatomic) TopAndInquiryView *inquiryView;

@end

@implementation TopAndInquiryViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额充值查询";
    self.view.backgroundColor = [UIColor whiteColor];

    self.inquiryView = [[TopAndInquiryView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.inquiryView];
}

@end
