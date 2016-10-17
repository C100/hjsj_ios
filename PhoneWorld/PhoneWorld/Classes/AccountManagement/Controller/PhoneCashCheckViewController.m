//
//  OrderCheckViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneCashCheckViewController.h"
#import "PhoneCashCheckView.h"

@interface PhoneCashCheckViewController ()
@property (nonatomic) PhoneCashCheckView *phoneCashCheckView;
@end

@implementation PhoneCashCheckViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"号码余额查询";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    
    self.phoneCashCheckView = [[PhoneCashCheckView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.phoneCashCheckView];
    [self.phoneCashCheckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    __block __weak PhoneCashCheckViewController *weakself = self;
    [self.phoneCashCheckView setOrderCallBack:^(NSInteger tag) {
        //查询操作
        NSString *phoneNum = weakself.phoneCashCheckView.phoneNum;
        if([Utils isMobile:phoneNum]){
            
            //查询操作
            weakself.phoneCashCheckView.userinfos = @[@"账户余额：99元",@"资费信息",@"111",@"222",@"333",@"311",@"113",@"211",@"112"];
            [weakself.phoneCashCheckView resultTableView];
            
        }else{
            [Utils toastview:@"手机号格式不正确，请重新输入"];
        }
    }];
    
}

@end
