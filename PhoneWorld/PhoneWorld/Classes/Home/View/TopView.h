//
//  TopView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView

@property (nonatomic) NSArray *titles;

@property (nonatomic) UIView *titlesView;
@property (nonatomic) UIView *siftView;//筛选栏

@property (nonatomic) UIButton *showButton;//保存用

@property (nonatomic) UIView *lineView;

@property (nonatomic) NSMutableArray *titlesButton;

@property (nonatomic) void(^callback)(NSInteger tag);

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;

/*--------查询的筛选信息---height 72---*/
@property (nonatomic) UILabel *orderTimeLB;
@property (nonatomic) UILabel *orderStateLB;
@property (nonatomic) UILabel *orderPhoneLB;

@end
