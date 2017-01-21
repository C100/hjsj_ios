//
//  OrderMainView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/22.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterView.h" //筛选框
#import "TopView.h"  //头部筛选栏
#import "ContentView.h"  //内容

@interface OrderMainView : UIView <UIScrollViewDelegate>
@property (nonatomic) TopView *topView;//标题栏
@property (nonatomic) FilterView *selectView;//筛选new
@property (nonatomic) ContentView *contentScrollView;


@property (nonatomic) NSInteger selectedIndex;

@end
