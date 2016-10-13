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
    self.view.backgroundColor = [UIColor whiteColor];
    self.checkAndTopView = [[CheckAndTopView alloc] init];
    [self.view addSubview:self.checkAndTopView];
    [self.checkAndTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    __block __weak CheckAndTopViewController *weakself = self;
    [self.checkAndTopView setCheckAndTopCallBack:^(NSInteger tag) {
        switch (tag) {
            case 501:
            {
                weakself.checkAndTopView.greenCheckIV1.hidden = NO;
                weakself.checkAndTopView.greenCheckIV2.hidden = YES;
            }
                break;
            case 502:
            {
                weakself.checkAndTopView.greenCheckIV2.hidden = NO;
                weakself.checkAndTopView.greenCheckIV1.hidden = YES;
            }
                break;
            case 503:
            {
                if ([weakself.checkAndTopView.moneyNum.text isEqualToString:@""]) {
                    [Utils toastview:@"请输入金额"];
                }else{
                    if ([Utils isNumber:weakself.checkAndTopView.moneyNum.text]) {
                        if (weakself.checkAndTopView.greenCheckIV1.hidden == NO) {
                            //阿里支付
                        }else if(weakself.checkAndTopView.greenCheckIV2 == NO){
                            //微信支付
                        }else{
                            [Utils toastview:@"请选择支付方式"];
                        }
                    }else{
                        [Utils toastview:@"请输入金额"];
                    }
                }
            }
                break;
        }
    }];
    
}

@end
