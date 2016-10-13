//
//  ContentView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(screenWidth * 5, 0);
        self.bounces = NO;
        self.pagingEnabled = YES;
        [self addSubview:self.pageView1.view];
        [self addSubview:self.pageView2.view];
        [self addSubview:self.pageView3.view];
        [self addSubview:self.pageView4.view];
        [self addSubview:self.pageView5.view];
    }
    return self;
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
        _pageView2.view.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight - 108 - 80);
    }
    return _pageView2;
}

-(TransferViewController *)pageView3{
    if (_pageView3 == nil) {
        _pageView3 = [TransferViewController new];
        _pageView3.view.frame = CGRectMake(screenWidth*2, 0, screenWidth, screenHeight - 108 - 80);
    }
    return _pageView3;
}

- (RepairCardViewController *)pageView4{
    if (_pageView4 == nil) {
        _pageView4 = [RepairCardViewController new];
        _pageView4.view.frame = CGRectMake(screenWidth*3, 0, screenWidth, screenHeight - 108 - 80);
    }
    return _pageView4;
}

- (TopUpViewController *)pageView5{
    if (_pageView5 == nil) {
        _pageView5 = [TopUpViewController new];
        _pageView5.view.frame = CGRectMake(screenWidth*4, 0, screenWidth, screenHeight - 108 - 80);
    }
    return _pageView5;
}

@end
