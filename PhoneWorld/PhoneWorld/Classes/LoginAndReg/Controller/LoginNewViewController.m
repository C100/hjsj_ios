//
//  LoginNewViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/12/10.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "LoginNewViewController.h"
#import "LoginNewView.h"

#import "ForgetPasswordViewController.h"
#import "MainTabBarController.h"
#import "RegisterViewController.h"

#import "AppDelegate.h"

@interface LoginNewViewController () <UITextFieldDelegate>

@property (nonatomic) LoginNewView *loginNewView;

@property (nonatomic) BOOL hasPassword;

@end

@implementation LoginNewViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    
    if ([userD objectForKey:@"password"]) {
        self.loginNewView.passwordTextField.text = @"123456789012";
        self.loginNewView.usernameTextField.text = [userD objectForKey:@"username"];
        self.hasPassword = YES;
    }else{
        self.hasPassword = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginNewView = [[LoginNewView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:self.loginNewView];
    
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.loginNewView.passwordTextField.delegate = self;
    
    
    __block __weak LoginNewViewController *weakself = self;

    [self.loginNewView setLoginCallBack:^(NSString *title) {
        if ([title isEqualToString:@"登    录"]) {
            NSString *username = weakself.loginNewView.usernameTextField.text;
            NSString *password = weakself.loginNewView.passwordTextField.text;
            if ([username isEqualToString:@""]) {
                [Utils toastview:@"请输入用户名"];
                return ;
            }
            if ([password isEqualToString:@""]) {
                [Utils toastview:@"请输入密码"];
                return ;
            }
            
            if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
                weakself.loginNewView.loginButton.userInteractionEnabled = YES;
            }
            
            NSString *passwordMD5 = weakself.loginNewView.passwordTextField.text;
            
            if (self.hasPassword == NO) {
                passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",password]];//得到md5加密过后密码
            }else{
                passwordMD5 = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
            }

            
            [WebUtils requestLoginResultWithUserName:username andPassword:passwordMD5 andWebUtilsCallBack:^(id obj) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.loginNewView.loginButton.userInteractionEnabled = YES;
                });
                if (obj) {
                    if ([obj[@"code"] isEqualToString:@"10000"]) {
                        //缓存
                        
                        
                        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                        [ud removeObjectForKey:@"username"];
                        [ud removeObjectForKey:@"password"];
                        [ud synchronize];
                        
                        [ud setObject:username forKey:@"username"];
                        [ud setObject:passwordMD5 forKey:@"password"];
                        [ud setObject:obj[@"data"][@"session_token"] forKey:@"session_token"];
                        [ud setObject:obj[@"data"][@"grade"] forKey:@"grade"];
                        [ud synchronize];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
//                            MainTabBarController *vc = [[MainTabBarController alloc] init];
//                            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
                            
                            [weakself.view endEditing:YES];
                                                                                    
                            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                            [appDelegate gotoHomeVC];
                        });
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:@"用户名或密码错误，请重新输入!"];
                        });
                    }
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:@"系统异常，请稍后重试！"];
                    });
                }
                
            }];

            
        }
        
        if ([title isEqualToString:@"点击注册"]) {
            RegisterViewController *vc = [[RegisterViewController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        }
        
        if ([title isEqualToString:@"忘记密码？"]) {
            ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.hasPassword = NO;
    return YES;
}

@end
