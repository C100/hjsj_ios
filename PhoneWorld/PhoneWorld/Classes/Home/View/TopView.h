//
//  TopView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView

@property (nonatomic) UIView *titlesView;
@property (nonatomic) UIView *siftView;

@property (nonatomic) NSMutableArray *titlesButton;

@property (nonatomic) void(^callback)(NSInteger tag);

@end
