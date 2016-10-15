//
//  CreatePayPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CreatePayPasswordViewController.h"
#import "CreatePayPasswordView.h"

@interface CreatePayPasswordViewController ()
@property (nonatomic) CreatePayPasswordView *createView;
@end

@implementation CreatePayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付密码创建";
    self.createView = [[CreatePayPasswordView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.createView];
}

@end
