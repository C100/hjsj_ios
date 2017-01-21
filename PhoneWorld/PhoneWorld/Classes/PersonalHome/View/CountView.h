//
//  CountView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/21.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountView : UIView
- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;

@property (nonatomic) PNLineChart *lineChart;

//月份
@property (nonatomic) NSArray *accountsOpenedArr;//数量
@property (nonatomic) NSArray *accountsOpenedMonthArr;//时间
//年份
@property (nonatomic) NSArray *accountsOpenedYearArr;//年时间
@property (nonatomic) NSArray *accountsOpendCountYearArr;//年数量

@property (nonatomic) CGFloat average;
@property (nonatomic) CGFloat max;

@property (nonatomic) CGFloat average2;
@property (nonatomic) CGFloat max2;

@end
