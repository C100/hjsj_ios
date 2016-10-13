//
//  ContentView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenAccomplishCardViewController.h"
#import "OpenWhiteCardViewController.h"
#import "TransferViewController.h"
#import "RepairCardViewController.h"
#import "TopUpViewController.h"

@interface ContentView : UIScrollView

@property (nonatomic) OpenAccomplishCardViewController *pageView1;
@property (nonatomic) OpenWhiteCardViewController *pageView2;
@property (nonatomic) TransferViewController *pageView3;
@property (nonatomic) RepairCardViewController *pageView4;
@property (nonatomic) TopUpViewController *pageView5;

@end
