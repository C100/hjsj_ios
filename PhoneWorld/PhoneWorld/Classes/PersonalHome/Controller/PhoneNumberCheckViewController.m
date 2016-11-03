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

@interface PhoneNumberCheckViewController ()
@property (nonatomic) PhoneNumberCheckView *checkView;
@property (nonatomic) FailedView *succeedView;
@end

@implementation PhoneNumberCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机号码验证";
    self.checkView = [[PhoneNumberCheckView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.checkView];
    
    __block __weak PhoneNumberCheckViewController *weakself = self;

    [self.checkView setSendCaptchaCallBack:^(id obj) {
        if (weakself.type == 4) {
            //支付密码修改
            [WebUtils requestSendCaptchaWithType:weakself.type andTel:weakself.checkView.inputView.textField.text andCallBack:^(id obj) {
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
    
    [self.checkView setNextStepCallBack:^(id button) {
        [WebUtils requestCaptchaCheckWithCaptcha:weakself.checkView.codeTF.text andType:weakself.type andTel:weakself.checkView.inputView.textField.text andCallBack:^(id obj) {
            NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if (obj) {
                if ([code isEqualToString:@"10000"]) {
                    //验证成功
                    
                    [WebUtils requestAlterPayPasswordWithNewPassword:weakself.newsPass andOldPassword:weakself.oldPass andCallBack:^(id obj) {
                        NSString *mes2 = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                        NSString *code2 = [NSString stringWithFormat:@"%@",obj[@"code"]];
                        if ([code2 isEqualToString:@"10000"]) {
                            //密码修改成功
                        }else{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [Utils toastview:mes2];
                            });
                        }
                    }];
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:mes];
                    });
                }
            }
        }];
    }];
    
}

@end
