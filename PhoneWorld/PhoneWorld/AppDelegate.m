//
//  AppDelegate.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "LoginNewViewController.h"
#import "LoginNaviViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    
    
    /*--判断版本号--*/
    
    //初始化网络判断
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //微信
    [WXApi registerApp:@"wxf52ad75c5c060b9e" withDescription:@"demo 2.0"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([ud objectForKey:@"username"] && [ud objectForKey:@"session_token"]) {
        
        [self gotoHomeVC];
        
    }else{
        
        LoginNewViewController *newVC = [[LoginNewViewController alloc] init];
        self.window.rootViewController = [[LoginNaviViewController alloc] initWithRootViewController:newVC];
        
    }
    
    //键盘控件
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//控制整个功能是否启用
    manager.enableAutoToolbar = NO;//控制是否显示键盘上的工具条
    manager.shouldResignOnTouchOutside = YES;//点击背景收回键盘
    
    return YES;
}

- (void)gotoHomeVC{
    MainTabBarController *vc = [MainTabBarController new];
    self.window.rootViewController = vc;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            self.payResult = NO;
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                self.payResult = YES;
            }
            self.AppCallBack(self.payResult);
        }];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    //点击home退出界面时（程序进入后台）进入
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [WebUtils requestWithTouchTimes];//上传点击次数
    
    [ud removeObjectForKey:@"phoneRecharge"];
    [ud removeObjectForKey:@"accountRecharge"];
    [ud removeObjectForKey:@"transform"];
    [ud removeObjectForKey:@"renewOpen"];
    [ud removeObjectForKey:@"newOpen"];
    [ud removeObjectForKey:@"replace"];
    [ud removeObjectForKey:@"phoneBanlance"];
    [ud removeObjectForKey:@"accountRecord"];
    [ud removeObjectForKey:@"cardQuery"];
    [ud removeObjectForKey:@"orderQueryRenew"];
    [ud removeObjectForKey:@"orderQueryNew"];
    [ud removeObjectForKey:@"orderQueryTransform"];
    [ud removeObjectForKey:@"orderQueryReplace"];
    [ud removeObjectForKey:@"orderQueryRecharge"];
    [ud removeObjectForKey:@"qdsList"];
    [ud removeObjectForKey:@"qdsOrderList"];
    
    [ud synchronize];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //重新进入刷新
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:0 forKey:@"phoneRecharge"];
    [ud setInteger:0 forKey:@"accountRecharge"];
    [ud setInteger:0 forKey:@"transform"];
    [ud setInteger:0 forKey:@"renewOpen"];
    [ud setInteger:0 forKey:@"newOpen"];
    [ud setInteger:0 forKey:@"replace"];
    [ud setInteger:0 forKey:@"phoneBanlance"];
    [ud setInteger:0 forKey:@"accountRecord"];
    [ud setInteger:0 forKey:@"cardQuery"];
    [ud setInteger:0 forKey:@"orderQueryRenew"];
    [ud setInteger:0 forKey:@"orderQueryNew"];
    [ud setInteger:0 forKey:@"orderQueryTransform"];
    [ud setInteger:0 forKey:@"orderQueryReplace"];
    [ud setInteger:0 forKey:@"orderQueryRecharge"];
    [ud setInteger:0 forKey:@"qdsList"];
    [ud setInteger:0 forKey:@"qdsOrderList"];
    [ud synchronize];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
