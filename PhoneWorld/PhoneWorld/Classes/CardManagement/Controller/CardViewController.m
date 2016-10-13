//
//  CardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardViewController.h"
#import "CardView.h"
#import "FinishCardViewController.h"
#import "TransferCardViewController.h"
#import "CardRepairViewController.h"

@interface CardViewController ()
@property (nonatomic) CardView *cardView;
@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.cardView = [[CardView alloc] init];
    [self.view addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_equalTo(-44);
    }];
    __block __weak CardViewController *weakself = self;
    [self.cardView setMyCallBack:^(NSInteger tag) {
        switch (tag) {
            case 300:
            {
                FinishCardViewController *vc = [FinishCardViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 301:
            {
                
            }
                break;
            case 302:
            {
                TransferCardViewController *vc = [TransferCardViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 303:
            {
                CardRepairViewController *vc = [CardRepairViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 304:
            {
                
            }
                break;
        }
    }];
}

@end
