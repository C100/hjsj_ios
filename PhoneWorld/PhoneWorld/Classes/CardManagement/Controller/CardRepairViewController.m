//
//  CardRepairViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardRepairViewController.h"
#import "RepairCardView.h"
#import "FailedView.h"

@interface CardRepairViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) RepairCardView *repairCardView;
@property (nonatomic) UIButton *currentButton;
@property (nonatomic) FailedView *finishedView;

@property (nonatomic) FailedView *processView;//过程弹窗

@end

@implementation CardRepairViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"补卡";
    
    self.repairCardView = [[RepairCardView alloc] init];
    [self.view addSubview:self.repairCardView];
    [self.repairCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    __block __weak CardRepairViewController *weakself = self;
    
    [self.repairCardView setCardRepairCallBack:^(NSMutableDictionary *dic) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.processView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"正在提交" andDetail:@"请耐心等待..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
            [[UIApplication sharedApplication].keyWindow addSubview:weakself.processView];
        });
        
        //提交补卡信息
        [WebUtils requestRepairInfoWithDic:dic andCallBack:^(id obj) {
            if (obj) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.processView removeFromSuperview];
                });
                
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.finishedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"提交成功" andDetail:@"请耐心等待..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
                        [[UIApplication sharedApplication].keyWindow addSubview:weakself.finishedView];
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
        self.finishedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.finishedView removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

@end
