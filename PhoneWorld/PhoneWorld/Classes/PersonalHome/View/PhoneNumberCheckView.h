//
//  PhoneNumberCheckView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

@interface PhoneNumberCheckView : UIView

@property (nonatomic) void(^sendCaptchaCallBack)(id obj);
@property (nonatomic) void(^nextStepCallBack) (id obj);
@property (nonatomic) InputView *inputView;
@property (nonatomic) UIButton *nextButton;
@property (nonatomic) UITextField *codeTF;

@end
