//
//  TopCallMoneyView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopCallMoneyView : UIView

@property (nonatomic) void(^topCallMoneyCallBack) (NSInteger tag, NSInteger money);

@property (nonatomic) UILabel *leftMoney;// 话费余额
@property (nonatomic) UILabel *phoneNum;
@property (nonatomic) UITextField *phoneTF;// 手机号码
@property (nonatomic) UILabel *topMoney;
@property (nonatomic) UIButton *topButton;// 充值按钮

@end
