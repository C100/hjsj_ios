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
@property (nonatomic) UIView *topMoneyNumber;
@property (nonatomic) UIButton *nextButton;
@property (nonatomic) PayView *payView;

@end
