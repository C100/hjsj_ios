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

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *homeVC = [HomeViewController new];
    homeVC.title = @"话机世界";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"home"];
    homeVC.tabBarItem.title = @"首页";
    
    OrderViewController *orderVC = [OrderViewController new];
    orderVC.title = @"订单查询";
    orderVC.tabBarItem.image = [UIImage imageNamed:@"order"];
    orderVC.tabBarItem.title = @"订单查询";
    
    AccountViewController *accountVC = [AccountViewController new];
    accountVC.title = @"账户管理";
    accountVC.tabBarItem.image = [UIImage imageNamed:@"setting"];
    accountVC.tabBarItem.title = @"账户管理";
    
    CardViewController *cardVC = [CardViewController new];
    cardVC.title = @"卡片管理";
    cardVC.tabBarItem.image = [UIImage imageNamed:@"card"];
    cardVC.tabBarItem.title = @"卡片管理";
    
    self.viewControllers = @[[[MainNavigationController alloc] initWithRootViewController:homeVC], [[MainNavigationController alloc] initWithRootViewController:orderVC], [[MainNavigationController alloc] initWithRootViewController:accountVC], [[MainNavigationController alloc] initWithRootViewController:cardVC]];
    
    self.tabBar.tintColor = MainColor;
    self.tabBar.translucent = NO;
}

@end
