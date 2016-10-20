//
//  ReadCardAndChoosePackageView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadCardAndChoosePackageView : UIView <UITextFieldDelegate>

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSArray *)info;

@property (nonatomic) UIView *infoView;
@property (nonatomic) UIButton *nextButton;
@property (nonatomic) UITextField *moneyTF;

@end
