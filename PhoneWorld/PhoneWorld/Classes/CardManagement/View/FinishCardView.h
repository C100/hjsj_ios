//
//  FinishCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishCardView : UIView <UITextFieldDelegate>

@property (nonatomic) void(^FinishCardCallBack)(NSString *tel,NSString *puk);
@property (nonatomic) UIButton *nextButton;

@end
