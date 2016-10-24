//
//  ReadCardAndChoosePackageViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ReadCardAndChoosePackageViewController.h"
#import "ReadCardAndChoosePackageView.h"

@interface ReadCardAndChoosePackageViewController ()
@property (nonatomic) ReadCardAndChoosePackageView *readView;
@end

@implementation ReadCardAndChoosePackageViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.title = @"读卡与套餐选择";
    self.readView = [[ReadCardAndChoosePackageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andInfo:self.infos];
    [self.view addSubview:self.readView];
}

@end
