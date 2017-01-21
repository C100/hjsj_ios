//
//  SettlementDetailView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneDetailModel.h"

@interface SettlementDetailView : UIView

@property (nonatomic) void(^SubmitCallBack) (id obj);

@property (nonatomic) UIButton *nextButton;

@property (nonatomic) NSMutableArray *leftLabelsArray;

@end
