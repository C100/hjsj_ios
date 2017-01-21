//
//  FinishCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "FinishCardViewController.h"
#import "FinishCardView.h"
#import "FailedView.h"

#import "ChoosePackageViewController.h"
#import "PhoneDetailModel.h"

@interface FinishCardViewController ()

@property (nonatomic) FinishCardView *finishCardView;
@property (nonatomic) FailedView *failedView;

@end

@implementation FinishCardViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

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
    
    __block __weak FinishCardViewController *weakself = self;

    [self.finishCardView setFinishCardCallBack:^(NSString *tel, NSString *puk) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utils toastview:@"正在查询，请稍后！"];
            weakself.finishCardView.nextButton.userInteractionEnabled = NO;
        });
        
        //判断网络
        
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            weakself.finishCardView.nextButton.userInteractionEnabled = YES;
        }
        
        [WebUtils requestFinishedCardWithTel:tel andPUK:puk andCallBack:^(id obj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.finishCardView.nextButton.userInteractionEnabled = YES;
            });
            if (obj) {
                
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    
                    if ([obj[@"data"] isKindOfClass:[NSNull class]]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [Utils toastview:@"后台无数据"];
                        });
                    }else{
                        //成功--------------
                        NSDictionary *dic = obj[@"data"];
                        PhoneDetailModel *detailModel = [[PhoneDetailModel alloc] initWithDictionary:dic error:nil];
                        ChoosePackageViewController *vc = [ChoosePackageViewController new];
                        vc.detailModel = detailModel;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakself.navigationController pushViewController:vc animated:YES];
                        });
                    }
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                        //失败
                        weakself.failedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"验证失败" andDetail:mes andImageName:@"attention" andTextColorHex:@"#333333"];
                        
                        [[UIApplication sharedApplication].keyWindow addSubview:weakself.failedView];
                        
                        [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(removeGrayView) userInfo:nil repeats:NO];
                        
                    });
                }
                
            }
        }];
    }];
}

- (void)removeGrayView{
    [UIView animateWithDuration:0.5 animations:^{
        self.failedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.failedView removeFromSuperview];
    }];
}

@end
