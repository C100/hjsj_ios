//
//  AlterLoginPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AlterLoginPasswordViewController.h"
#import "AlterLoginPasswordView.h"

@interface AlterLoginPasswordViewController ()
@property (nonatomic) AlterLoginPasswordView *alterView;
@end

@implementation AlterLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录密码修改";
    self.alterView = [[AlterLoginPasswordView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.alterView];
    [self.alterView setAlterPasswordCallBack:^(NSInteger tag) {
        if (tag == 1160) {
            NSLog(@"----------登录密码修改");
        }
    }];
}

@end
