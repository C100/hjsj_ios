//
//  WhiteCardFilterView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/24.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhiteCardTopView : UIView
@property (nonatomic) void(^WhiteCardTopCallBack)(id obj);
@property (nonatomic) NSMutableArray *resultArr;//结果Label
@property (nonatomic) UIButton *showButton;
@property (nonatomic) UIView *resultView;

@end
