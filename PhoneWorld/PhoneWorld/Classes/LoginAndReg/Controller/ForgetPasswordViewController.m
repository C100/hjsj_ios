//
//  ForgetPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordView.h"

@interface ForgetPasswordViewController ()
@property (nonatomic) ForgetPasswordView *forgetView;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"号码验证";
    self.view.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
    self.forgetView = [[ForgetPasswordView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.forgetView];
    
    __block __weak ForgetPasswordViewController *weakself = self;
    [self.forgetView setForgetCallBack:^(NSInteger tag) {
        if (tag == 1103) {
             //下一步
            if ([Utils isMobile:weakself.forgetView.phoneNumTF.text]) {
                
            }else{
                [Utils toastview:@"请输入正确格式手机号"];
            }
        }
        if(tag == 1104){
            //发送验证码
            NSLog(@"-------------发送验证码");
        }
    }];
}

@end
