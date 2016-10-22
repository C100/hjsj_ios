//
//  InformationCollectionView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationCollectionView : UIView

- (instancetype)initWithFrame:(CGRect)frame andUserinfos:(NSMutableDictionary *)userinfos;
@property (nonatomic) UIButton *nextButton;
@property (nonatomic) NSMutableDictionary *userinfosDic;

@end
