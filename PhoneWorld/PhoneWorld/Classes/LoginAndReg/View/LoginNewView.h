//
//  LoginNewView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/12/10.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginNewView : UIView

@property (nonatomic) void(^LoginCallBack)(NSString *title);

@property (nonatomic) UIImageView *backImageView;

@property (nonatomic) UIImageView *logoImageView;

@property (nonatomic) UITextField *usernameTextField;

@property (nonatomic) UITextField *passwordTextField;

@property (nonatomic) UIButton *forgetPasswordButton;

@property (nonatomic) UIButton *loginButton;

@property (nonatomic) UIButton *registerButton;

@end
