//
//  PersonalInfoViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalInfoView.h"
#import "PersonalInfoModel.h"

@interface PersonalInfoViewController ()
@property (nonatomic) PersonalInfoView *personalInfoView;
@property (nonatomic) PersonalInfoModel *personalInfoModel;
@end

@implementation PersonalInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self getUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    self.personalInfoView = [[PersonalInfoView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    self.personalInfoView.contentSize = CGSizeMake(0, 520);
    [self.view addSubview:self.personalInfoView];
}

- (void)getUserInfo{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:@"username"];
    NSString *token = [ud objectForKey:@"session_token"];
    [WebUtils requestPersonalInfoWithSessionToken:token andUserName:username andCallBack:^(id obj) {
        if (obj) {
            NSDictionary *dic = obj[@"data"];
            self.personalInfoModel = [[PersonalInfoModel alloc] initWithDictionary:dic error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.personalInfoView.personModel = self.personalInfoModel;
            });
        }
    }];
}

@end
