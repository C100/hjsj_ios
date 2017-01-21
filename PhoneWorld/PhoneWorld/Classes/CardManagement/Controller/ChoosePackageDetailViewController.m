//
//  ChoosePackageDetailViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChoosePackageDetailViewController.h"

@interface ChoosePackageDetailViewController ()

@property (nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation ChoosePackageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    
    __block __weak ChoosePackageDetailViewController *weakself = self;
    
    if ([self.title isEqualToString:@"活动包选择"]) {
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicatorView.frame = CGRectMake(0, 0, 100, 100);
        self.indicatorView.center = CGPointMake(screenWidth/2, (screenHeight-64)/2);
        [self.view addSubview:self.indicatorView];
        [self.indicatorView setHidesWhenStopped:YES];
        [self.indicatorView startAnimating];
        
        [WebUtils requestPackagesWithID:self.currentID andCallBack:^(id obj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.indicatorView stopAnimating];
            });
            
            if (obj) {
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    
                    NSArray *promotionsArray = obj[@"data"][@"promotions"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        weakself.packagesDic = promotionsArray;//所有活动包
                        
                        weakself.detailView = [[ChoosePackageDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andPackages:weakself.packagesDic];
                        weakself.detailView.delegate = (id)weakself.packageTableView;
                        [weakself.view addSubview:weakself.detailView];
                        
                    });
                    
                    
                }else{
                    NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:mes];
                    });
                }
            }
        }];
    }else{
        self.detailView = [[ChoosePackageDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) andPackages:self.packagesDic];
        self.detailView.delegate = (id)self.packageTableView;
        [self.view addSubview:self.detailView];
    }

    

}

@end
