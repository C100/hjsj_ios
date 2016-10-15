//
//  LoginView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (nonatomic) void(^LoginCallBack)(NSInteger tag);

@property (nonatomic) UITextField *usernameTF;
@property (nonatomic) UITextField *passwordTF;
@property (nonatomic) UIButton *forgetPassword;
@property (nonatomic) UIButton *submitButton;

@end
