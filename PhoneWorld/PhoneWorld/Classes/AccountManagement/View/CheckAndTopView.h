//
//  CheckAndTopView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

typedef enum : NSUInteger {
    aliPay,
    weixinPay,
} payWay;

@interface CheckAndTopView : UIView <UITextFieldDelegate>

@property (nonatomic) void(^checkAndTopCallBack)(NSString* money, payWay payway);
@property (nonatomic) payWay payway;
@property (nonatomic) UIView *payWay;
@property (nonatomic) NSMutableArray *buttons;
@property (nonatomic) UIButton *nextButton;

@property (nonatomic) InputView *accountMoneyInputView;

@end
