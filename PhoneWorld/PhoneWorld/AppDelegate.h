//
//  AppDelegate.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)gotoHomeVC;

//返回支付宝支付结果是否成功
@property (nonatomic) BOOL payResult;
@property (nonatomic) void(^AppCallBack) (BOOL result);

@end

