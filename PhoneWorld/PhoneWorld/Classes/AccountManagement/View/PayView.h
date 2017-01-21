//
//  PayView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayView : UIView <UITextFieldDelegate>

@property (nonatomic) void(^PayCallBack)(NSString *password);
@property (nonatomic) void(^ClosePayCallBack)(id obj);

@property (nonatomic) UIButton *closeButton;//关闭按钮
@property (nonatomic, strong) UITextField *textField;//密码输入框

@end
