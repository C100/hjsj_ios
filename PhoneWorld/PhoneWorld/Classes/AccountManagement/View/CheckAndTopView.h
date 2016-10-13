//
//  CheckAndTopView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckAndTopView : UIView

@property (nonatomic) void(^checkAndTopCallBack)(NSInteger tag);

@property (nonatomic) UILabel *currentLeftMoney;//余额
@property (nonatomic) UILabel *topMoney;
@property (nonatomic) UILabel *payType;
@property (nonatomic) UITextField *moneyNum;//充值金额
@property (nonatomic) UIButton *aliPay;
@property (nonatomic) UIButton *weixinPay;

@property (nonatomic) UIImageView *greenCheckIV1;
@property (nonatomic) UIImageView *greenCheckIV2;

@property (nonatomic) UIButton *rechargeButton;

@end
