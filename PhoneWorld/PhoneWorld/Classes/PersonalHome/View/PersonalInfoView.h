//
//  PersonalInfoView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInfoModel.h"

@interface PersonalInfoView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic) UIButton *saveButton;
@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) PersonalInfoModel *personModel;

@end
