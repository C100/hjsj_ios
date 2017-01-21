//
//  OrderView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

@interface PhoneCashCheckView : UIView


@property (nonatomic) void(^orderCallBack)(NSString *phoneNumber);

@property (nonatomic) UIButton *findButton;

@property (nonatomic) UIView *resultView;
@property (nonatomic) UILabel *resultLabel;

@property (nonatomic) InputView *inputView;

@end
