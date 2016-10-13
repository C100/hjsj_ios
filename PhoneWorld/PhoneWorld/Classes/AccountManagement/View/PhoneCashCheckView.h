//
//  OrderView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneCashCheckView : UIView

@property (nonatomic) void(^orderCallBack)(NSInteger tag);

@property (nonatomic) UILabel *phoneLB;
@property (nonatomic) UITextField *phoneTF;
@property (nonatomic) UIButton *findButton;
@property (nonatomic) UIView *lineView;

@property (nonatomic) UILabel *accountCash;//账户余额


@end
