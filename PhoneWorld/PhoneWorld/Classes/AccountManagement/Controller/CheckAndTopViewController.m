//
//  CheckAndTopViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CheckAndTopViewController.h"
#import "CheckAndTopView.h"

@interface CheckAndTopViewController ()
@property (nonatomic) CheckAndTopView *checkAndTopView;
@end

@implementation CheckAndTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"号码余额查询与充值";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.checkAndTopView = [[CheckAndTopView alloc] init];
    [self.view addSubview:self.checkAndTopView];
    [self.checkAndTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    __block __weak CheckAndTopViewController *weakself = self;
    
    [self.checkAndTopView setCheckAndTopCallBack:^(NSString *money, payWay payway) {
        
        if ([Utils isNumber:money]) {
            
        }
    }];
}

@end
