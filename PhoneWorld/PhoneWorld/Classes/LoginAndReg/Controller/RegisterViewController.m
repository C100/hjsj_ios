//
//  RegisterViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
#import "RegisterModel.h"
#import "FailedView.h"

@interface RegisterViewController ()
@property (nonatomic) RegisterView *registerView;
@property (nonatomic) FailedView *waitView;
@property (nonatomic) FailedView *resultView;
@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.registerView = [[RegisterView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.registerView];
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    __block __weak RegisterViewController *weakself = self;

    [self.registerView setRegisterCallBack:^(id obj,NSString *phoneNumberString,NSString *captchaString) {
        RegisterModel *regModel = obj;

        /*------注册接口中需要传验证码，说明注册接口就验证过了---------*/
        weakself.waitView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"正在注册" andDetail:@"请稍候..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
        [[UIApplication sharedApplication].keyWindow addSubview:weakself.waitView];
        [WebUtils requestRegisterResultWithRegisterModel:regModel andCallBack:^(id obj) {
            if (obj) {
                if ([obj[@"code"] isEqualToString:@"10000"]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIView animateWithDuration:0.5 animations:^{
                            weakself.waitView.alpha = 0;
                        } completion:^(BOOL finished) {
                            [weakself.waitView removeFromSuperview];
                            weakself.resultView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"注册成功" andDetail:@"请耐心等待1-2个审核日" andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
                            [[UIApplication sharedApplication].keyWindow addSubview:weakself.resultView];
                            [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(dismissResultViewAction) userInfo:nil repeats:NO];
                        }];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                        [UIView animateWithDuration:0.5 animations:^{
                            weakself.waitView.alpha = 0;
                        } completion:^(BOOL finished) {
                            [weakself.waitView removeFromSuperview];
                            weakself.resultView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"注册失败" andDetail:mes andImageName:@"icon_cry" andTextColorHex:@"#0081eb"];
                            [[UIApplication sharedApplication].keyWindow addSubview:weakself.resultView];
                            [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(failedRegisterAction) userInfo:nil repeats:NO];
                        }];
                    });
                }
            }
        }];
        /*------------------注册---------------------------------------*/
    }];
}

- (void)dismissResultViewAction{
    [UIView animateWithDuration:0.5 animations:^{
        self.resultView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.resultView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)failedRegisterAction{
    [UIView animateWithDuration:0.5 animations:^{
        self.resultView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.resultView removeFromSuperview];
    }];
}

@end
