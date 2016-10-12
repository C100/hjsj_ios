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

#import "DropDownView.h"
#import "TopView.h"

#define selectV 220/375.0

@interface OrderViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic) UIPageViewController *pageController;

@property (nonatomic) OpenAccomplishCardViewController *pageView1;
@property (nonatomic) OpenWhiteCardViewController *pageView2;
@property (nonatomic) TransferViewController *pageView3;
@property (nonatomic) RepairCardViewController *pageView4;
@property (nonatomic) TopUpViewController *pageView5;

@property (nonatomic) NSArray *viewCons;

@property (nonatomic) DropDownView *selectView;

@property (nonatomic) TopView *topView;

@property (nonatomic) NSInteger pageI;

@property (nonatomic) UIView *grayView;

@property (nonatomic) UITapGestureRecognizer *tapGrayGR;

@end

@implementation OrderViewController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 80)];
    [self.view addSubview:self.topView];
    [self pageController];
    self.pageI = 0;
    
    self.selectView = [[DropDownView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, 220)];
    self.selectView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.selectView];
    self.selectView.hidden = YES;
    
    [self grayView];
    
    __block __weak OrderViewController *weakself = self;
    [self.topView setCallback:^(NSInteger tag) {
        /*---按钮点击事件---*/
        
        switch (tag) {
            case 101:{
                [UIView animateWithDuration:0.3 animations:^{
                    if (weakself.selectView.hidden == NO) {
                        weakself.selectView.hidden = YES;
                        weakself.grayView.hidden = YES;
                    }else{
                        weakself.selectView.hidden = NO;
                        weakself.grayView.hidden = NO;
                    }
                }];
            }
                break;
                
            default:
                break;
        }
        
    }];
}


#pragma mark - UIPageViewController Delegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
//    self.pageI --;
//    if (self.pageI < 0) {
//        self.pageI = self.viewCons.count;
//    }

    NSInteger index = [self.viewCons indexOfObject:viewController];
    index --;
    if (index == -1) {
        return self.viewCons.lastObject;
    }
    for (UIButton *b in self.topView.titlesButton) {
        b.selected = NO;
    }
    UIButton *btn = self.topView.titlesButton[index];
    btn.selected = YES;
    
    
    return self.viewCons[index];
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
//    self.pageI ++;
//    if (self.pageI == self.viewCons.count) {
//        self.pageI = 0;
//    }
//    NSLog(@"after======%ld",self.pageI);
    NSInteger index = [self.viewCons indexOfObject:viewController];
    index ++;
    if (index == self.viewCons.count) {
        return self.viewCons.firstObject;
    }
    
    for (UIButton *b in self.topView.titlesButton) {
        b.selected = NO;
    }
    UIButton *btn = self.topView.titlesButton[index];
    btn.selected = YES;
    
    return self.viewCons[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    self.pageI = [self indexCon:[self.pageController.viewControllers lastObject]];
    for (UIButton *b in self.topView.titlesButton) {
        b.selected = NO;
    }
    UIButton *btn = self.topView.titlesButton[self.pageI];
    btn.selected = YES;
}

- (NSInteger)indexCon:(UIViewController *)viewController{
    for (int i = 0; i < self.viewCons.count; i ++) {
        if (viewController == [_viewCons objectAtIndex:i]) {
            return i;
        }
    }
    return NSNotFound;
}

#pragma mark - LazyLoading
- (UIPageViewController *)pageController{
    if (_pageController == nil) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:0];
        _pageController.view.tag = 1000;
        _pageController.delegate = self;
        _pageController.dataSource = self;
        [self addChildViewController:_pageController];
        [self.view addSubview:_pageController.view];
        _pageController.view.backgroundColor = [UIColor yellowColor];
        [_pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);;
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(screenHeight - 108 - 80);
        }];
        [_pageController setViewControllers:@[self.pageView1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    return _pageController;
}

- (OpenAccomplishCardViewController *)pageView1{
    if (_pageView1 == nil) {
        _pageView1 = [OpenAccomplishCardViewController new];
        _pageView1.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 108);
    }
    return _pageView1;
}

- (OpenWhiteCardViewController *)pageView2{
    if (_pageView2 == nil) {
        _pageView2 = [OpenWhiteCardViewController new];
        _pageView2.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80);
    }
    return _pageView2;
}

-(TransferViewController *)pageView3{
    if (_pageView3 == nil) {
        _pageView3 = [TransferViewController new];
        _pageView3.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80);
    }
    return _pageView3;
}

- (RepairCardViewController *)pageView4{
    if (_pageView4 == nil) {
        _pageView4 = [RepairCardViewController new];
        _pageView4.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80);
    }
    return _pageView4;
}

- (TopUpViewController *)pageView5{
    if (_pageView5 == nil) {
        _pageView5 = [TopUpViewController new];
        _pageView5.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80);
    }
    return _pageView5;
}

- (NSArray *)viewCons{
    if (_viewCons == nil) {
        _viewCons = @[self.pageView1, self.pageView2, self.pageView3, self.pageView4, self.pageView5];
    }
    return _viewCons;
}

- (UIView *)grayView{
    if (_grayView == nil) {
        _grayView = [[UIView alloc] init];
        [self.view addSubview:_grayView];
        _grayView.backgroundColor = [UIColor lightGrayColor];
        _grayView.alpha = 0.5;
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.selectView.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        _grayView.hidden = YES;
        [_grayView addGestureRecognizer:self.tapGrayGR];
    }
    return _grayView;
}

- (UITapGestureRecognizer *)tapGrayGR{
    if (_tapGrayGR == nil) {
        _tapGrayGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    }
    return _tapGrayGR;
}

#pragma mark - Method
- (void)tapAction{
    __block __weak OrderViewController *weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (weakself.selectView.hidden == NO) {
            weakself.selectView.hidden = YES;
            weakself.grayView.hidden = YES;
        }else{
            weakself.selectView.hidden = NO;
            weakself.grayView.hidden = NO;
        }
    }];
}

@end
