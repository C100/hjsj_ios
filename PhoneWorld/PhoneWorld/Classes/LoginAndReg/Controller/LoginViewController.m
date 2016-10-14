//
//  LoginViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "ForgetPasswordViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface LoginViewController ()
@property (nonatomic) LoginView *loginView;
@end

@implementation LoginViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"话机世界";
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.loginView];
    
    __weak __block LoginViewController *weakself = self;
    [self.loginView setLoginCallBack:^(NSInteger tag) {
        switch (tag) {
            case 1100:
            {
                //注册
            }
                break;
            case 1101:
            {
                //忘记密码
                ForgetPasswordViewController *vc = [ForgetPasswordViewController new];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1102:
            {
                //登录提交
//                AppDelegate *del = [UIApplication sharedApplication].delegate;
//                [del gotoHomeVC];
                MainTabBarController *vc = [MainTabBarController new];
                [weakself presentViewController:vc animated:YES completion:nil];
            }
                break;
        }
    }];
}

- (void)dealloc{
    NSLog(@"================loginViewController已经销毁");
}

@end
