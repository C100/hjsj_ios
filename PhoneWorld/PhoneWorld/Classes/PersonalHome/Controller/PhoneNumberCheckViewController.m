//
//  PhoneNumberCheckViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneNumberCheckViewController.h"
#import "PhoneNumberCheckView.h"
#import "FailedView.h"

#import "AlterPayPasswordViewController.h"

#import "LoginNaviViewController.h"
#import "LoginNewViewController.h"

@interface PhoneNumberCheckViewController ()
@property (nonatomic) PhoneNumberCheckView *checkView;
@property (nonatomic) FailedView *succeedView;
@end

@implementation PhoneNumberCheckViewController

- (void)viewDidLoad {
    //不需要发送手机号的验证码专用
    [super viewDidLoad];
    self.title = @"手机号码验证";
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    self.checkView = [[PhoneNumberCheckView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.checkView];
    
    __block __weak PhoneNumberCheckViewController *weakself = self;

    
    //发送验证码
    [self.checkView setSendCaptchaCallBack:^(id obj) {
        if (weakself.type == 4) {
            //支付密码修改
            [WebUtils requestSendCaptchaWithType:weakself.type andTel:@"无" andCallBack:^(id obj) {
                if (obj) {
                    if ([obj[@"code"] isEqualToString:@"10000"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:@"验证码发送成功！"];
                        });
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:@"验证码发送失败！"];
                        });
                    }
                }
            }];
        }
    }];
    
    
    //下一步验证验证码
    [self.checkView setNextStepCallBack:^(id button) {
        
        weakself.checkView.nextButton.userInteractionEnabled = NO;
        
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            weakself.checkView.nextButton.userInteractionEnabled = YES;
        }
        
        [WebUtils requestCaptchaCheckWithCaptcha:weakself.checkView.codeTF.text andType:weakself.type andTel:@"无" andCallBack:^(id obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if (obj) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.checkView.nextButton.userInteractionEnabled = YES;
                });
                
                if ([code isEqualToString:@"10000"]) {
                    //验证成功
                    
                    if (weakself.type == 4) {
                        //支付密码修改
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            AlterPayPasswordViewController *vc = [AlterPayPasswordViewController new];
                            [weakself.navigationController pushViewController:vc animated:YES];
                        });
                    }
                    
                }else{
                    
                    NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                    if ([code isEqualToString:@"39999"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                            [ud removeObjectForKey:@"username"];
                            [ud removeObjectForKey:@"password"];
                            [ud removeObjectForKey:@"session_token"];
                            [ud removeObjectForKey:@"grade"];
                            [ud removeObjectForKey:@"hasPayPassword"];
                            [ud synchronize];
                            
                            LoginNaviViewController *naviVC = [[LoginNaviViewController alloc] initWithRootViewController:[[LoginNewViewController alloc] init]];
                            
                            [weakself presentViewController:naviVC animated:YES completion:nil];
                            
                        });
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:mes];
                        });
                    }
                }
            }
        }];
    }];
    
}

@end
