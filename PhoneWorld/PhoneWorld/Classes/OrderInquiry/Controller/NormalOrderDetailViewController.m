//
//  NormalOrderViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "NormalOrderDetailViewController.h"
#import "NormalOrderDetailView.h"

@interface NormalOrderDetailViewController ()
@property (nonatomic) NormalOrderDetailView *normalOrderDetailView;
@end

@implementation NormalOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.normalOrderDetailView = [[NormalOrderDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.normalOrderDetailView];
}

@end