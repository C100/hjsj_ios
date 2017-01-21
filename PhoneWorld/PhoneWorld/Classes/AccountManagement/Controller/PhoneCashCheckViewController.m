//
//  OrderCheckViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneCashCheckViewController.h"
#import "PhoneCashCheckView.h"
#import "FailedView.h"

@interface PhoneCashCheckViewController ()

@property (nonatomic) PhoneCashCheckView *phoneCashCheckView;
@property (nonatomic) FailedView *failedView;

@end

@implementation PhoneCashCheckViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"号码余额查询";
    
    self.phoneCashCheckView = [[PhoneCashCheckView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.phoneCashCheckView];
    [self.phoneCashCheckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    __block __weak PhoneCashCheckViewController *weakself = self;
    [self.phoneCashCheckView setOrderCallBack:^(NSString *phoneNumber) {
        //查询操作
        
        weakself.phoneCashCheckView.findButton.userInteractionEnabled = NO;
        
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            weakself.phoneCashCheckView.findButton.userInteractionEnabled = YES;
            [Utils toastview:@"网络不好"];
        }
        
        [WebUtils requestPhoneNumberMoneyWithNumber:phoneNumber andCallBack:^(id obj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.phoneCashCheckView.findButton.userInteractionEnabled = YES;
            });
            
            if (obj) {
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *moneyString = [NSString stringWithFormat:@"号码余额：%@",obj[@"data"][@"money"]];                        
                        [weakself.phoneCashCheckView resultView];
                        weakself.phoneCashCheckView.resultLabel.text = moneyString;
                        weakself.phoneCashCheckView.findButton.hidden = YES;
                        weakself.phoneCashCheckView.inputView.textField.userInteractionEnabled = NO;
                    });
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.failedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"无法查询，请去网络供应商查询" andDetail:nil andImageName:@"attention" andTextColorHex:@"#333333"];
                        [[UIApplication sharedApplication].keyWindow addSubview:weakself.failedView];
                        [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(dismissFailedView) userInfo:nil repeats:NO];
                    });
                    
                }
            }
        }];
        
        //如果查询失败弹出框：无法查询，请去网络供应商查询
        
    }];
    
}

- (void)dismissFailedView{
    [UIView animateWithDuration:0.5 animations:^{
        self.failedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.failedView removeFromSuperview];
    }];
}

@end
