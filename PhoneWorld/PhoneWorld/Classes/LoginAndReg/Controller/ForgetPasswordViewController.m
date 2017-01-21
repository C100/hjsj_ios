//
//  ForgetPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordView.h"
#import "ResetPasswordViewController.h"

@interface ForgetPasswordViewController ()
@property (nonatomic) ForgetPasswordView *forgetView;
@end

@implementation ForgetPasswordViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"号码验证";
    self.view.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
    self.forgetView = [[ForgetPasswordView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.forgetView];
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];

    __block __weak ForgetPasswordViewController *weakself = self;
    [self.forgetView setForgetCallBack:^(NSInteger tag, NSString *phoneNumber, NSString *codeString) {
        if (tag == 1103) {
            //下一步

            [WebUtils requestCaptchaCheckWithCaptcha:codeString andType:2 andTel:phoneNumber andCallBack:^(id obj) {
                if (obj) {
                    NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                    if ([code isEqualToString:@"10000"]) {
                        //验证成功
                        dispatch_async(dispatch_get_main_queue(), ^{
                            ResetPasswordViewController *vc = [[ResetPasswordViewController alloc] init];
                            vc.telString = phoneNumber;
                            vc.captchaString = codeString;
                            [weakself.navigationController pushViewController:vc animated:YES];
                        });
                    }else{
                        NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:mes];
                        });
                    }
                }
            }];
            
        }
        if(tag == 1104){
            
            
//            if (weakself.forgetView.isChecked == NO) {
//                [WebUtils requestIsHJSJNumberWithNumber:phoneNumber andCallBack:^(id obj) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        weakself.forgetView.isChecked = YES;
//                    });
//                    if (obj) {
//                        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
//                        if ([code isEqualToString:@"10000"]) {
//                            
//                        }else{
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [Utils toastview:@"请输入正确手机号！"];
//                            });
//                        }
//                    }
//                }];
//            }
            
            //发送验证码
            [WebUtils requestSendCaptchaWithType:2 andTel:phoneNumber andCallBack:^(id obj) {
                if (obj) {
                    NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                    if ([code isEqualToString:@"10000"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:@"验证码已发送"];
                        });
                    }else{
                        NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:mes];
                        });
                    }
                }
            }];
        }
    }];
}

@end
