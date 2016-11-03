//
//  AlterPayPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AlterPayPasswordViewController.h"
#import "AlterLoginPasswordView.h"
#import "PhoneNumberCheckViewController.h"
#import "InputView.h"

@interface AlterPayPasswordViewController ()
@property (nonatomic) AlterLoginPasswordView *alterView;
@end

@implementation AlterPayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付密码修改";
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];

    self.alterView = [[AlterLoginPasswordView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andType:2];
    [self.view addSubview:self.alterView];
    __block __weak AlterPayPasswordViewController *weakself = self;
    [self.alterView setAlterPasswordCallBack:^(id obj) {
        //手机号验证
        InputView *oldV = weakself.alterView.inputViews.firstObject;
        InputView *newV = weakself.alterView.inputViews.lastObject;
        PhoneNumberCheckViewController *vc = [[PhoneNumberCheckViewController alloc] init];
        vc.oldPass = oldV.textField.text;
        vc.newsPass = newV.textField.text;
        vc.type = 4;
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
}

@end
