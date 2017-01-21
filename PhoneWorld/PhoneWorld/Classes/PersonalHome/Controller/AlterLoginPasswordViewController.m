//
//  AlterLoginPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AlterLoginPasswordViewController.h"
#import "AlterLoginPasswordView.h"
#import "FailedView.h"
#import "InputView.h"

@interface AlterLoginPasswordViewController ()
@property (nonatomic) AlterLoginPasswordView *alterView;
@property (nonatomic) FailedView *succeedView;
@end

@implementation AlterLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录密码修改";
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];

    self.alterView = [[AlterLoginPasswordView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andType:1];
    [self.view addSubview:self.alterView];
    __block __weak AlterLoginPasswordViewController *weakself = self;
    [self.alterView setAlterPasswordCallBack:^(id obj) {
        InputView *oldV = weakself.alterView.inputViews.firstObject;
        InputView *newV = weakself.alterView.inputViews.lastObject;
        
        weakself.alterView.saveButton.userInteractionEnabled = NO;
        
        if([[AFNetworkReachabilityManager sharedManager] isReachable] == NO){
            weakself.alterView.saveButton.userInteractionEnabled = YES;
        }
        
        [WebUtils requestAlterPasswordWithOldPassword:oldV.textField.text andNewPassword:newV.textField.text andCallBack:^(id obj) {
            if (obj) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.alterView.saveButton.userInteractionEnabled = YES;
                });
                
                if ([obj[@"code"] isEqualToString:@"10000"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //操作
                        weakself.succeedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"修改成功" andDetail:@"正在跳转..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
                        [[UIApplication sharedApplication].keyWindow addSubview:weakself.succeedView];
                        [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(dismissResultViewAction) userInfo:nil repeats:NO];
                    });
                }else{
                    //操作
                    dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.succeedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"修改失败" andDetail:@"请重新修改!" andImageName:@"icon_cry" andTextColorHex:@"#0081eb"];
                    [[UIApplication sharedApplication].keyWindow addSubview:weakself.succeedView];
                    [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(dismissOnlyAction) userInfo:nil repeats:NO];
                    });

                }
            }
        }];
    }];
}

- (void)dismissResultViewAction{
    [UIView animateWithDuration:0.5 animations:^{
        self.succeedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.succeedView removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

- (void)dismissOnlyAction{
    [UIView animateWithDuration:0.5 animations:^{
        self.succeedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.succeedView removeFromSuperview];
    }];
}

@end
