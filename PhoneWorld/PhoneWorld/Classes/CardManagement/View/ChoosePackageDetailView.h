//
//  ChoosePackageDetailView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoosePackageDetailViewDelegate <NSObject>

- (void)getPackage:(NSDictionary *)package;

@end

@interface ChoosePackageDetailView : UIView

- (instancetype)initWithFrame:(CGRect)frame andPackages:(NSArray *)packages;

@property (nonatomic) id<ChoosePackageDetailViewDelegate> delegate;

@property (nonatomic) NSArray *packagesDic;//套餐包

@property (nonatomic) NSDictionary *currentDic;//当前套餐包

@property (nonatomic) UILabel *detailLabel;//套餐详情

@end
