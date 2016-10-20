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

@interface PasswordManageViewController ()
@property (nonatomic) PasswordManageView *passwordManageView;
@end

@implementation PasswordManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码管理";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    
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
                AlterPayPasswordViewController *vc = [AlterPayPasswordViewController new];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }];
}
@end
