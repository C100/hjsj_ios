//
//  ResetPasswordView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordView : UIView

@property (nonatomic) void(^ResetPasswordCallBack) (NSInteger tag);

@property (nonatomic) UITextField *passwordTF;
@property (nonatomic) UITextField *passwordAgainTF;
@property (nonatomic) UIButton *finishButton;

@end
