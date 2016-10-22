//
//  PersonalInfoView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame andUserinfos:(NSMutableArray *)userinfos;

@property (nonatomic) NSMutableArray *userinfos;

@property (nonatomic) UIButton *saveButton;

@end
