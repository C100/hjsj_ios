//
//  OrderCheckViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneCashCheckViewController.h"
#import "OrderView.h"

@interface PhoneCashCheckViewController ()
@property (nonatomic) OrderView *orderView;
@end

@implementation PhoneCashCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.orderView = [[OrderView alloc] init];
    [self.view addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
}

@end
