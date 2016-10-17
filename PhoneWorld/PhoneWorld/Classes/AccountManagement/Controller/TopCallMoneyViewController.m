//
//  TopCallMoneyViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopCallMoneyViewController.h"
#import "TopCallMoneyView.h"

@interface TopCallMoneyViewController ()
@property (nonatomic) TopCallMoneyView *topCallMoneyView;
@end

@implementation TopCallMoneyViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"话费充值";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    self.topCallMoneyView = [[TopCallMoneyView alloc] init];
    [self.view addSubview:self.topCallMoneyView];
    [self.topCallMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    __block __weak TopCallMoneyViewController *weakself = self;
    [self.topCallMoneyView setTopCallMoneyCallBack:^(NSInteger tag, NSInteger money) {
        if (tag == 650) {
            //话费充值确定操作
            if (money == 0) {
                [Utils toastview:@"请选择充值面额"];
            }else if([Utils isMobile:weakself.topCallMoneyView.phoneTF.text] == NO){
                [Utils toastview:@"请输入正确手机号"];
            }else{
                NSLog(@"--------确定？");
            }            
        }
    }];
}

@end
