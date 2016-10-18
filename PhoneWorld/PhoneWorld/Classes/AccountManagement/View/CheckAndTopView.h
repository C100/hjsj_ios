//
//  CheckAndTopView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    weixinPay,
    aliPay,
} payWay;

@interface CheckAndTopView : UIView <UITextFieldDelegate>

@property (nonatomic) void(^checkAndTopCallBack)(NSString* money, payWay payway);

@property (nonatomic) payWay payway;
@property (nonatomic) UILabel *currentLeftMoney;
@property (nonatomic) UILabel *currentRightMoney;
@property (nonatomic) UIView *topMoney;
@property (nonatomic) UITextField *moneyNumTF;

@property (nonatomic) UIView *payWay;
@property (nonatomic) NSMutableArray *buttons;
@property (nonatomic) UILabel *number;

@property (nonatomic) UIButton *nextButton;

@end
