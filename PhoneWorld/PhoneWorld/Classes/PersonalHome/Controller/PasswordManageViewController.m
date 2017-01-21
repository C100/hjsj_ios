//
//  PasswordManageViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PasswordManageViewController.h"
#import "PasswordManageView.h"
#import "AlterLoginPasswordViewController.h"
#import "CreatePayPasswordViewController.h"
#import "AlterPayPasswordViewController.h"

#import "PhoneNumberCheckViewController.h"

@interface PasswordManageViewController ()
@property (nonatomic) PasswordManageView *passwordManageView;
@end

@implementation PasswordManageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码管理";    
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.passwordManageView = [[PasswordManageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.passwordManageView];
    __block __weak PasswordManageViewController *weakself = self;
    [self.passwordManageView setPasswordManagerCallBack:^(NSInteger row) {
        switch (row) {
            case 0:
            {
                AlterLoginPasswordViewController *vc = [AlterLoginPasswordViewController new];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                CreatePayPasswordViewController *vc = [CreatePayPasswordViewController new];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                
                //先手机验证再修改支付密码
                
                PhoneNumberCheckViewController *phoneCheckViewController = [[PhoneNumberCheckViewController alloc] init];
                phoneCheckViewController.type = 4;
                [weakself.navigationController pushViewController:phoneCheckViewController animated:YES];
            }
                break;
        }
    }];
}
@end
