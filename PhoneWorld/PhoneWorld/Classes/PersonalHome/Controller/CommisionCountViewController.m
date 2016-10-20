//
//  CommisionCountViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CommisionCountViewController.h"

@interface CommisionCountViewController ()

@end

@implementation CommisionCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.title = @"佣金统计";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

@end
