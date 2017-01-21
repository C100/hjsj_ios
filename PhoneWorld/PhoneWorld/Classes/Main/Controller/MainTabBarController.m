//
//  MainTabBarController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "OrderViewController.h"
#import "AccountViewController.h"
#import "CardViewController.h"
#import "MainNavigationController.h"

#import "ChannelPartnersManageViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.title = @"话机世界";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"home"];
    homeVC.tabBarItem.title = @"首页";
    
    OrderViewController *orderVC = [OrderViewController shareOrderViewController];
    orderVC.title = @"订单查询";
    orderVC.tabBarItem.image = [UIImage imageNamed:@"order"];
    orderVC.tabBarItem.title = @"订单查询";
    
    ChannelPartnersManageViewController *channelVC = [ChannelPartnersManageViewController sharedChannelPartnersManageViewController];
    channelVC.title = @"渠道商管理";
    channelVC.tabBarItem.image = [UIImage imageNamed:@"order"];
    channelVC.tabBarItem.title = @"渠道商管理";
    
    AccountViewController *accountVC = [AccountViewController new];
    accountVC.title = @"账户管理";
    accountVC.tabBarItem.image = [UIImage imageNamed:@"setting"];
    accountVC.tabBarItem.title = @"账户管理";
    
    CardViewController *cardVC = [CardViewController new];
    cardVC.title = @"卡片管理";
    cardVC.tabBarItem.image = [UIImage imageNamed:@"card"];
    cardVC.tabBarItem.title = @"卡片管理";
    
    //区分用户等级
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *grade = [ud objectForKey:@"grade"];
    
    if ([grade isEqualToString:@"lev1"] || [grade isEqualToString:@"lev2"]) {
        //代理商 功能少
        
        self.viewControllers = @[[[MainNavigationController alloc] initWithRootViewController:homeVC], [[MainNavigationController alloc] initWithRootViewController:channelVC]];

        
    }else if([grade isEqualToString:@"lev3"]){
        //渠道商  功能多
        
        self.viewControllers = @[[[MainNavigationController alloc] initWithRootViewController:homeVC], [[MainNavigationController alloc] initWithRootViewController:orderVC], [[MainNavigationController alloc] initWithRootViewController:accountVC], [[MainNavigationController alloc] initWithRootViewController:cardVC]];
        
    }else if([grade isEqualToString:@"lev0"]){
        //lev0 总 话机最高帐号
        
        self.viewControllers = @[[[MainNavigationController alloc] initWithRootViewController:homeVC], [[MainNavigationController alloc] initWithRootViewController:orderVC], [[MainNavigationController alloc] initWithRootViewController:channelVC], [[MainNavigationController alloc] initWithRootViewController:accountVC], [[MainNavigationController alloc] initWithRootViewController:cardVC]];
    }
    
    //暂时不区分用户等级
//    self.viewControllers = @[[[MainNavigationController alloc] initWithRootViewController:homeVC], [[MainNavigationController alloc] initWithRootViewController:orderVC], [[MainNavigationController alloc] initWithRootViewController:channelVC], [[MainNavigationController alloc] initWithRootViewController:accountVC], [[MainNavigationController alloc] initWithRootViewController:cardVC]];

    
    self.tabBar.tintColor = MainColor;
    self.tabBar.translucent = NO;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}


@end
