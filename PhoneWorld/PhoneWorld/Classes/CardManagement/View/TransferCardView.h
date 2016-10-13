//
//  TransferCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferCardView : UIScrollView

@property (nonatomic) UILabel *transferLB;
@property (nonatomic) UITextField *transferTF;

@property (nonatomic) UILabel *nameLB;
@property (nonatomic) UITextField *nameTF;

@property (nonatomic) UILabel *IDCardLB;
@property (nonatomic) UITextField *IDCardTF;

@property (nonatomic) UILabel *phoneLB;
@property (nonatomic) UITextField *phoneTF;

@property (nonatomic) UILabel *addressLB;
@property (nonatomic) UITextView *addressTV;

@property (nonatomic) UILabel *theNewUserLB;
@property (nonatomic) UIButton *theNewFrontBtn;

@property (nonatomic) UILabel *theOldUserLB;
@property (nonatomic) UIButton *theOldFrontBtn;

@property (nonatomic) UIButton *nextBtn;

@end
