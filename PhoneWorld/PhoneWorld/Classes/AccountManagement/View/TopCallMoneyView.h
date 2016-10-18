//
//  TopCallMoneyView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayView.h"

@interface TopCallMoneyView : UIView <UITextFieldDelegate>

@property (nonatomic) void(^topCallMoneyCallBack) (NSInteger money, NSString *phoneNumber);

@property (nonatomic) UILabel *currentLeftMoney;
@property (nonatomic) UILabel *currentRightMoney;
@property (nonatomic) UIView *phoneNumView;
@property (nonatomic) UILabel *phoneNumberLB;
@property (nonatomic) UITextField *phoneNumberTF;

@property (nonatomic) UIView *topMoneyNumber;
@property (nonatomic) UIView *topMoney;
@property (nonatomic) UILabel *number;//保存充值金额的Label
@property (nonatomic) UITextField *moneyNumberTF;//保存充值金额的TF

@property (nonatomic) UIButton *nextButton;

@property (nonatomic) PayView *payView;

@end
