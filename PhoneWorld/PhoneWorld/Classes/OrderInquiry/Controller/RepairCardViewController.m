//
//  RepairCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RepairCardViewController.h"
#import "OrderView.h"

@interface RepairCardViewController ()
@property (nonatomic) OrderView *orderView;
@end

@implementation RepairCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.orderView = [[OrderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80)];
    [self.view addSubview:self.orderView];
}

@end
