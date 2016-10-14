//
//  TopUpViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopUpViewController.h"
#import "OrderTwoView.h"

@interface TopUpViewController ()
@property (nonatomic) OrderTwoView *orderTwoView;
@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.orderTwoView = [[OrderTwoView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80)];
    [self.view addSubview:self.orderTwoView];
}

@end
