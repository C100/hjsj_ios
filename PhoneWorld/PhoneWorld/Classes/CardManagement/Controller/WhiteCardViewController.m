//
//  WhiteCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "WhiteCardViewController.h"
#import "WhiteCardView.h"

@interface WhiteCardViewController ()
@property (nonatomic) WhiteCardView *whiteCardView;
@end

@implementation WhiteCardViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"渠道商列表";
    
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.whiteCardView = [[WhiteCardView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.whiteCardView];
}

@end
