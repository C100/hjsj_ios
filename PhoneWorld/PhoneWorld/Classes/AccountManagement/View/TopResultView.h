//
//  TopResultView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopResultView : UIView
- (instancetype)initWithFrame:(CGRect)frame andIsSucceed:(BOOL)isSucceed;

@property (nonatomic) BOOL isSucceed;
@property (nonatomic) UIView *stateView;

@property (nonatomic) UIView *detailView;
@property (nonatomic) NSArray *detailArr;
@property (nonatomic) UIButton *nextButton;

@end
