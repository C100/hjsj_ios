//
//  TopCallMoneyView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayView.h"
#import "InputView.h"

@interface TopCallMoneyView : UIView <UITextFieldDelegate>

@property (nonatomic) void(^topCallMoneyCallBack) (CGFloat money, NSString *phoneNumber, NSString *numbers, NSString *status);
@property (nonatomic) UIView *topMoneyNumber;//后台给的优惠金额显示界面
@property (nonatomic) UIButton *nextButton;//下一步
@property (nonatomic) PayView *payView;//6位密码输入框
@property (nonatomic) UIView *grayView;//6位密码输入框后面的灰色半透明背景
@property (nonatomic) InputView *accountMoneyIV;//账户余额

@property (nonatomic) NSArray *discountArray;//后台返回的优惠数组

@end
