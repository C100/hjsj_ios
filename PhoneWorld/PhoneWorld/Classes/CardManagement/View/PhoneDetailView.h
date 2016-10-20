//
//  PhoneDetailView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneDetailView : UIView

- (instancetype)initWithFrame:(CGRect)frame andPhoneInfo:(NSArray *)phoneInfo;

@property (nonatomic) NSArray *phoneInfo;

@end
