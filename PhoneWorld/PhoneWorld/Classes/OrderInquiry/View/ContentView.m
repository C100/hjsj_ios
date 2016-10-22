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
        OpenAccomplishCardViewController *openVC = [OpenAccomplishCardViewController sharedOpenAccomplishCardViewController];
        openVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 108 -80);
        [self addSubview:openVC.view];
        
        OpenWhiteCardViewController *openWhiteVC = [OpenWhiteCardViewController sharedOpenWhiteCardViewController];
        openWhiteVC.view.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight - 108 - 80);
        [self addSubview:openWhiteVC.view];
        
        TransferViewController *transferVC = [TransferViewController sharedTransferViewController];
        transferVC.view.frame = CGRectMake(screenWidth*2, 0, screenWidth, screenHeight - 108 - 80);
        [self addSubview:transferVC.view];
        
        RepairCardViewController *repairVC = [RepairCardViewController sharedRepairCardViewController];
        repairVC.view.frame = CGRectMake(screenWidth*3, 0, screenWidth, screenHeight - 108 - 80);
        [self addSubview:repairVC.view];
        
        TopUpViewController *topVC = [TopUpViewController sharedTopUpViewController];
        topVC.view.frame = CGRectMake(screenWidth*4, 0, screenWidth, screenHeight - 108 - 80);
        [self addSubview:topVC.view];
    }
    return self;
}

@end
