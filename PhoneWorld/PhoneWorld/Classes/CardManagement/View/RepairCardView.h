//
//  RepairCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepairCardView : UIScrollView

@property (nonatomic) UIButton *nextButton;

@property (nonatomic) void(^CardRepairCallBack)(NSMutableDictionary *dic);

@property (nonatomic) BOOL isHJSJNumber;

@end
