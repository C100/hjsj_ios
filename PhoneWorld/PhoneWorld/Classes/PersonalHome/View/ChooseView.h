//
//  ChooseView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/21.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseView : UIView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;
@property (nonatomic) UIView *leftView;
@property (nonatomic) UILabel *titleLB;

@end
