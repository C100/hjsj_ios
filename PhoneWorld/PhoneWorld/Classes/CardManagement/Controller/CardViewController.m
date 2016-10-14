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

#import "MessageViewController.h"
#import "PersonalHomeViewController.h"

@interface CardViewController ()
@property (nonatomic) CardView *cardView;
@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"individualCenter"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoPersonalHomeVC)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"news_white"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMessagesVC)];

    
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

#pragma mark - Method
- (void)gotoMessagesVC{
    MessageViewController *messageVC = [MessageViewController new];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)gotoPersonalHomeVC{
    PersonalHomeViewController *vc = [PersonalHomeViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
