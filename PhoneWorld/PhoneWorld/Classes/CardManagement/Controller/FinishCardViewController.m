//
//  FinishCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "FinishCardViewController.h"
#import "FinishCardView.h"

@interface FinishCardViewController ()
@property (nonatomic) FinishCardView *finishCardView;
@end

@implementation FinishCardViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"号码验证";
    
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.finishCardView = [[FinishCardView alloc] init];
    [self.view addSubview:self.finishCardView];
    [self.finishCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.finishCardView setFinishCardCallBack:^(NSString *tel, NSString *puk) {
        [WebUtils requestFinishedCardWithTel:tel andPUK:puk andCallBack:^(id obj) {
            if (obj) {
                
            }
        }];
    }];
    
}

@end
