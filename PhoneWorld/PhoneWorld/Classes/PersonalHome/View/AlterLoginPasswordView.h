//
//  AlterLoginPasswordView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlterLoginPasswordView : UIView
@property (nonatomic) void(^AlterPasswordCallBack) (NSInteger tag);
@property (nonatomic) NSMutableArray *passwordTextFields;
@property (nonatomic) UIButton *saveButton;
@end
