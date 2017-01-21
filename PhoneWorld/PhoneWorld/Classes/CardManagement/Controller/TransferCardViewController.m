//
//  TransferCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TransferCardViewController.h"
#import "TransferCardView.h"
#import "FailedView.h"

@interface TransferCardViewController ()<UIScrollViewDelegate>
@property (nonatomic) TransferCardView *transferCardView;
@property (nonatomic) FailedView *processView;
@property (nonatomic) FailedView *successView;
@end

@implementation TransferCardViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"过户";
    
    self.transferCardView = [[TransferCardView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.transferCardView];
    
    __block __weak TransferCardViewController *weakself = self;

    [self.transferCardView setNextCallBack:^(NSDictionary * sendDic) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.processView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"正在提交" andDetail:@"请耐心等待..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
            [[UIApplication sharedApplication].keyWindow addSubview:weakself.processView];
        });
        
        
        [WebUtils requestTransferInfoWithDic:sendDic andCallBack:^(id obj) {
            if (obj) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.processView removeFromSuperview];
                });
                
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.successView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"提交成功" andDetail:@"请耐心等待..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
                        [[UIApplication sharedApplication].keyWindow addSubview:weakself.successView];
                        
                        [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(removeGrayView) userInfo:nil repeats:NO];
                    });
                    
                    
                    
                }else{
                    if (![code isEqualToString:@"39999"]) {
                        NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:mes];
                        });
                    }
                    
                }
            }
        }];
    }];
}

- (void)removeGrayView{
    [UIView animateWithDuration:0.5 animations:^{
        self.successView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.successView removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

@end
