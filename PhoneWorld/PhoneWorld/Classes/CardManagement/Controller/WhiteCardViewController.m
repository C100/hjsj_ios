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
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"渠道商列表";
    
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.whiteCardView = [[WhiteCardView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.whiteCardView];
}

@end
