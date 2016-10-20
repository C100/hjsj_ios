//
//  CardRepairViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardRepairViewController.h"
#import "RepairCardView.h"

@interface CardRepairViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) RepairCardView *repairCardView;
@property (nonatomic) UIButton *currentButton;
@end

@implementation CardRepairViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"补卡";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.repairCardView = [[RepairCardView alloc] init];
    [self.view addSubview:self.repairCardView];
    [self.repairCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
}

@end
