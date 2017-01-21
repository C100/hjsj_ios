//
//  CardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardViewController.h"
#import "CardManageView.h"

#import "FinishCardViewController.h"
#import "TransferCardViewController.h"
#import "CardRepairViewController.h"
#import "WhiteCardViewController.h"
#import "CardInquiryViewController.h"

#import "MessageViewController.h"
#import "PersonalHomeViewController.h"

@interface CardViewController ()

@property (nonatomic) CardManageView *cardView;

@end

@implementation CardViewController

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
    
    self.cardView = [[CardManageView alloc] init];
    [self.view addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_equalTo(0);
    }];
    __block __weak CardViewController *weakself = self;
    [self.cardView setMyCallBack:^(NSInteger row) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        switch (row) {
            case 0:
            {
                NSInteger i0 = [ud integerForKey:@"renewOpen"];
                i0 = i0 + 1;
                [ud setInteger:i0 forKey:@"renewOpen"];
                [ud synchronize];
                FinishCardViewController *vc = [FinishCardViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
//            case 1:
//            {
//                WhiteCardViewController *vc = [WhiteCardViewController new];
//                vc.hidesBottomBarWhenPushed = YES;
//                [weakself.navigationController pushViewController:vc animated:YES];
//            }
//                break;
            case 1:
            {
                NSInteger i1 = [ud integerForKey:@"transform"];
                i1 = i1 + 1;
                [ud setInteger:i1 forKey:@"transform"];
                [ud synchronize];
                TransferCardViewController *vc = [TransferCardViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                NSInteger i2 = [ud integerForKey:@"replace"];
                i2 = i2 + 1;
                [ud setInteger:i2 forKey:@"replace"];
                [ud synchronize];
                CardRepairViewController *vc = [CardRepairViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                NSInteger i3 = [ud integerForKey:@"cardQuery"];
                i3 = i3 + 1;
                [ud setInteger:i3 forKey:@"cardQuery"];
                [ud synchronize];
                CardInquiryViewController *vc = [CardInquiryViewController sharedCardInquiryViewController];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }];
}

@end
