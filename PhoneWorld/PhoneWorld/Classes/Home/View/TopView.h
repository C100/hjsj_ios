//
//  TopView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView

@property (nonatomic) void(^callback)(NSInteger tag);
@property (nonatomic) void(^TopCallBack) (id obj);

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;
@property (nonatomic) UIButton *showButton;//up按钮  只能传出去做动画
@property (nonatomic) NSMutableArray *titlesButton;
@property (nonatomic) NSMutableArray *resultArr;//结果Label

@property (nonatomic) UIButton *currentButton;

@end
