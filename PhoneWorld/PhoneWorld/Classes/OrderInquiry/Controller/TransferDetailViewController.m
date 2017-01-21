//
//  TransferDetailViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TransferDetailViewController.h"
#import "TransferDetailView.h"
#import "CardTransferDetailModel.h"

@interface TransferDetailViewController ()
@property (nonatomic) TransferDetailView *detailView;

@property (nonatomic) CardTransferDetailModel *detailModel;

@property (nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation TransferDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    

    
    
    self.detailView = [[TransferDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    self.detailView.listModel = self.listModel;
    [self.view addSubview:self.detailView];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.frame = CGRectMake(0, 0, 100, 100);
    self.indicatorView.center = CGPointMake(screenWidth/2, (screenHeight-64)/2);
    [self.view addSubview:self.indicatorView];
    [self.indicatorView setHidesWhenStopped:YES];
    [self.indicatorView startAnimating];
    
    [self requestOrderDetailWithOrderId:self.modelId];
}

- (void)requestOrderDetailWithOrderId:(NSString *)orderID{
    __block __weak TransferDetailViewController *weakself = self;
    [WebUtils requestTransferDetailWithId:orderID andCallBack:^(id obj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.indicatorView stopAnimating];
        });
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                NSDictionary *dic = obj[@"data"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.detailModel = [[CardTransferDetailModel alloc] initWithDictionary:dic error:nil];
                    weakself.detailView.detailModel = weakself.detailModel;
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
}

@end
