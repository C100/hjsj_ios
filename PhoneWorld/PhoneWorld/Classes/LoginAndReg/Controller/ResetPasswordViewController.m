//
//  ResetPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ResetPasswordView.h"

@interface ResetPasswordViewController ()
@property (nonatomic) ResetPasswordView *resetPasswordView;
@end

@implementation ResetPasswordViewController

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

@end
