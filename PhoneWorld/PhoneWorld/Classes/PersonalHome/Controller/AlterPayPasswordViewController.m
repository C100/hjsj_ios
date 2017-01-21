//
//  AlterPayPasswordViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AlterPayPasswordViewController.h"
#import "AlterLoginPasswordView.h"
#import "PhoneNumberCheckViewController.h"
#import "InputView.h"

@interface AlterPayPasswordViewController ()
@property (nonatomic) AlterLoginPasswordView *alterView;
@end

@implementation AlterPayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付密码修改";
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];

    self.alterView = [[AlterLoginPasswordView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andType:2];
    [self.view addSubview:self.alterView];
    __block __weak AlterPayPasswordViewController *weakself = self;
    [self.alterView setAlterPasswordCallBack:^(id obj) {
        
        InputView *oldV = weakself.alterView.inputViews.firstObject;
        InputView *newV = weakself.alterView.inputViews.lastObject;
        
        if (![Utils checkPayPassword:newV.textField.text]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [Utils toastview:@"请输入六位支付密码！"];
            });
            return ;
        }
        
        weakself.alterView.saveButton.userInteractionEnabled = NO;
        
        if([[AFNetworkReachabilityManager sharedManager] isReachable]){
            weakself.alterView.saveButton.userInteractionEnabled = YES;
        }
        
        [WebUtils requestAlterPayPasswordWithNewPassword:newV.textField.text andOldPassword:oldV.textField.text andCallBack:^(id obj) {
            if (obj) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.alterView.saveButton.userInteractionEnabled = YES;
                });
                
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:@"支付密码修改成功"];
                        
                        [weakself.navigationController popToRootViewControllerAnimated:YES];
                        
                    });
                    
                    
                }else{
                    NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:mes];
                    });
                }
            }
        }];
        

    }];
}

@end
