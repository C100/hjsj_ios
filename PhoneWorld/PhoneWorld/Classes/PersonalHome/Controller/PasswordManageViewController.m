//
//  PasswordManageViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PasswordManageViewController.h"
#import "PasswordManageView.h"

@interface PasswordManageViewController ()
@property (nonatomic) PasswordManageView *passwordManageView;
@end

@implementation PasswordManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码管理";
    self.passwordManageView = [[PasswordManageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.passwordManageView];
}
@end
