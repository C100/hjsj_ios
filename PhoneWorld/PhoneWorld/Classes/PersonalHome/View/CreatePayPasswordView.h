//
//  CreatePayPasswordView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePayPasswordView : UIView

@property (nonatomic) void(^CreatePayPasswordCallBack) (id obj);
@property (nonatomic) UIButton *saveButton;
@property (nonatomic) NSMutableArray *inputViews;

@end
