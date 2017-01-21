//
//  ForgetPasswordView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordView : UIView

@property (nonatomic) void(^ForgetCallBack)(NSInteger tag, NSString *phoneNumber, NSString *codeString);

@property (nonatomic) UITextField *phoneNumTF;
@property (nonatomic) UITextField *identifyingCodeTF;
@property (nonatomic) UIButton *nextButton;

@property (nonatomic) BOOL isChecked;

@end
