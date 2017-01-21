//
//  AccountViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AccountViewController.h"

#import "PhoneCashCheckViewController.h"
#import "CheckAndTopViewController.h"
#import "TopCallMoneyViewController.h"
#import "TopAndInquiryViewController.h"

#import "AccountView.h"

@interface AccountViewController ()

@property (nonatomic) AccountView *accountView;

@end

@implementation AccountViewController
#pragma mark - LifeCircle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.accountView = [[AccountView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.accountView];
    __block __weak AccountViewController *weakself = self;
    [self.accountView setAccountCallBack:^(NSInteger row) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        switch (row) {
            case 0:
            {
                NSInteger i0 = [ud integerForKey:@"phoneBanlance"];
                i0 = i0 + 1;
                [ud setInteger:i0 forKey:@"phoneBanlance"];
                [ud synchronize];
                PhoneCashCheckViewController *vc = [PhoneCashCheckViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:{
                NSInteger i1 = [ud integerForKey:@"accountRecord"];
                i1 = i1 + 1;
                [ud setInteger:i1 forKey:@"accountRecord"];
                [ud synchronize];
                CheckAndTopViewController *vc = [CheckAndTopViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:{
                NSInteger i2 = [ud integerForKey:@"phoneRecharge"];
                i2 = i2 + 1;
                [ud setInteger:i2 forKey:@"phoneRecharge"];
                [ud synchronize];
                TopCallMoneyViewController *vc = [TopCallMoneyViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                NSInteger i3 = [ud integerForKey:@"accountRecord"];
                i3 = i3 + 1;
                [ud setInteger:i3 forKey:@"accountRecord"];
                [ud synchronize];
                TopAndInquiryViewController *vc = [TopAndInquiryViewController sharedTopAndInquiryViewController];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }];
}

@end
