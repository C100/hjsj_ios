//
//  InformationCollectionView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"
#import "ChooseImageView.h"

@interface InformationCollectionView : UIView

@property (nonatomic) void(^nextCallBack)(NSDictionary *dic);
@property (nonatomic) UIButton *nextButton;
@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) ChooseImageView *chooseImageView;

- (instancetype)initWithFrame:(CGRect)frame andIsFinished:(BOOL)isFinished;

@end
