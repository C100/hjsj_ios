//
//  RightItemView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightItemView : UIView

+ (RightItemView *)sharedRightItemView;

@property (nonatomic) UIButton *rightButton;
@property (nonatomic) UILabel *redLabel;//小红点

@end
