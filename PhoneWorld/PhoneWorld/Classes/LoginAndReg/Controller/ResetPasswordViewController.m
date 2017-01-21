//
//  ResetPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ResetPasswordView.h"
#import "FailedView.h"
#import "LoginNaviViewController.h"
#import "LoginNewViewController.h"

@interface ResetPasswordViewController ()
@property (nonatomic) ResetPasswordView *resetPasswordView;
@property (nonatomic) FailedView *succeedView;
@end

@implementation ResetPasswordViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.title = @"重置密码";
    self.resetPasswordView = [[ResetPasswordView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.resetPasswordView];
    __block __weak ResetPasswordViewController *weakself = self;
    [self.resetPasswordView setResetPasswordCallBack:^(NSInteger tag) {
        if (tag == 1110) {
            if ([Utils checkPassword:weakself.resetPasswordView.passwordTF.text] && [weakself.resetPasswordView.passwordTF.text isEqualToString:weakself.resetPasswordView.passwordAgainTF.text]) {
                //如果密码一致且符合规则
                
                [WebUtils requestForgetPasswordWithTel:weakself.telString andCaptcha:weakself.captchaString andPassword:weakself.resetPasswordView.passwordTF.text andCallBack:^(id obj) {
                    if (obj) {
                        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                        if ([code isEqualToString:@"10000"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                weakself.succeedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"密码重置成功！" andDetail:@"请重新登陆" andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
                                [[UIApplication sharedApplication].keyWindow addSubview:weakself.succeedView];
                                [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(dismissResultViewAction) userInfo:nil repeats:NO];
                            });
                        }else{
                            NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [Utils toastview:mes];
                            });
                        }
                    }
                }];
                
            }else{
                if (![Utils checkPassword:weakself.resetPasswordView.passwordTF.text]) {
                    [Utils toastview:@"密码安全性太低，请重新设置"];
                }else if(![weakself.resetPasswordView.passwordTF.text isEqualToString:weakself.resetPasswordView.passwordAgainTF.text]){
                    [Utils toastview:@"两次密码不一致，请重新输入"];
                }
            }
        }
    }];
}

- (void)dismissResultViewAction{
    [UIView animateWithDuration:0.5 animations:^{
        self.succeedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.succeedView removeFromSuperview];
        
        LoginNaviViewController *naviVC = [[LoginNaviViewController alloc] initWithRootViewController:[[LoginNewViewController alloc] init]];
       
        [self presentViewController:naviVC animated:YES completion:nil];
    }];
}

@end
