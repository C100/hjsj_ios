//
//  ChoosePackageViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChoosePackageViewController.h"
#import "ChoosePackageView.h"

@interface ChoosePackageViewController ()
@property (nonatomic) ChoosePackageView *chooseView;
@end

@implementation ChoosePackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"套餐选择";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"返回";
    [backButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textfont14]} forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = backButton;
    
    self.chooseView = [[ChoosePackageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.chooseView];
    self.chooseView.detailModel = self.detailModel;
}

@end
