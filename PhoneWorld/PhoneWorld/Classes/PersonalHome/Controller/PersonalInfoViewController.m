//
//  PersonalInfoViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalInfoView.h"

@interface PersonalInfoViewController ()
@property (nonatomic) PersonalInfoView *personalInfoView;
@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.personalInfoView = [[PersonalInfoView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andUserinfos:[@[@"userinfos"] mutableCopy]];
    self.personalInfoView.contentSize = CGSizeMake(0, 520);
    [self.view addSubview:self.personalInfoView];
    [self.personalInfoView setPersonalInfoCallBack:^(id obj) {
        /*
         个人信息保存
         */
    }];
}

@end
