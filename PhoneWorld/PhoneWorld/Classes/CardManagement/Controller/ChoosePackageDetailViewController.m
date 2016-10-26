//
//  ChoosePackageDetailViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChoosePackageDetailViewController.h"

@interface ChoosePackageDetailViewController ()
@end

@implementation ChoosePackageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView = [[ChoosePackageDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    self.detailView.delegate = (id)self.packageTableView;
    [self.view addSubview:self.detailView];
}

@end
