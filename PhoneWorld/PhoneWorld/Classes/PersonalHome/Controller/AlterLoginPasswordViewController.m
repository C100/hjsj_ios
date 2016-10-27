//
//  AlterLoginPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AlterLoginPasswordViewController.h"
#import "AlterLoginPasswordView.h"
#import "PhoneNumberCheckViewController.h"

@interface AlterLoginPasswordViewController ()
@property (nonatomic) AlterLoginPasswordView *alterView;
@end

@implementation AlterLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录密码修改";
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];

    self.alterView = [[AlterLoginPasswordView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andType:1];
    [self.view addSubview:self.alterView];
    __block __weak AlterLoginPasswordViewController *weakself = self;
    [self.alterView setAlterPasswordCallBack:^(id obj) {
        //手机号验证
//        PhoneNumberCheckViewController *vc = [[PhoneNumberCheckViewController alloc] init];
//        [weakself.navigationController pushViewController:vc animated:YES];
    }];
}

@end
