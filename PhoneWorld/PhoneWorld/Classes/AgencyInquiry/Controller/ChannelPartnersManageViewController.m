//
//  ChannelPartnersManageViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChannelPartnersManageViewController.h"
#import "MessageViewController.h"
#import "PersonalHomeViewController.h"

#import "ChannelPartnersManageView.h"

@interface ChannelPartnersManageViewController ()
@property (nonatomic) ChannelPartnersManageView *channelView;
@end

@implementation ChannelPartnersManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"渠道商管理";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"individualCenter"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoPersonalHomeVC)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"news_white"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMessagesVC)];
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.channelView = [[ChannelPartnersManageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108)];
    [self.view addSubview:self.channelView];
    
}

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
