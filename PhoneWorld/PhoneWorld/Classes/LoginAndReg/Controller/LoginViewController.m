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
#import "RegisterViewController.h"

@interface LoginViewController ()
@property (nonatomic) LoginView *loginView;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"话机世界";
    self.view.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(RegisterAction)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"返回";
    [backButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = backButton;
    
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
                MainTabBarController *vc = [MainTabBarController new];
                [UIApplication sharedApplication].keyWindow.rootViewController = vc;
                [weakself.view endEditing:YES];
            }
                break;
        }
    }];
}

- (void)RegisterAction{
    RegisterViewController *vc = [RegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    NSLog(@"================loginViewController已经销毁");
}

@end
