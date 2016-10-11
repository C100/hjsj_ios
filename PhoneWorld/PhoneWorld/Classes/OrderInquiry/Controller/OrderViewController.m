//
//  OrderViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderViewController.h"
#import "DropDownView.h"
#import "OpenAccomplishCardViewController.h"
#import "OpenWhiteCardViewController.h"
#import "TransferViewController.h"
#import "RepairCardViewController.h"
#import "TopUpViewController.h"

@interface OrderViewController ()
@property (nonatomic) UIPageViewController *pageController;
@property (nonatomic) DropDownView *dropDownView;

@property (nonatomic) OpenAccomplishCardViewController *pageView1;
@property (nonatomic) OpenWhiteCardViewController *pageView2;
@property (nonatomic) TransferViewController *pageView3;
@property (nonatomic) RepairCardViewController *pageView4;
@property (nonatomic) TopUpViewController *pageView5;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIPageViewController *)pageController{
    if (_pageController == nil) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:0];
        [self.view addSubview:_pageController.view];
        [_pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(64);
            make.left.right.equalTo(0);
            make.height.equalTo(40);
        }];
        
    }
    return _pageController;
}

@end
