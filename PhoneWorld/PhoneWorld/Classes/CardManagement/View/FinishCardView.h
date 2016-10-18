//
//  FinishCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishCardView : UIView <UITextFieldDelegate>

@property (nonatomic) UIView *phoneView;
@property (nonatomic) UIView *pukView;

@property (nonatomic) UITextField *phoneTF;
@property (nonatomic) UILabel *phoneLB;
@property (nonatomic) UITextField *pukTF;
@property (nonatomic) UILabel *pukLB;

@property (nonatomic) UIButton *nextButton;

@end
