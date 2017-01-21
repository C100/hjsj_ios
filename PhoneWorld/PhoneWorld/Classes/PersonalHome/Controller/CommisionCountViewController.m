//
//  CommisionCountViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CommisionCountViewController.h"
#import "CommisionCountView.h"

@interface CommisionCountViewController ()
@property (nonatomic) CommisionCountView *countView;
@end

@implementation CommisionCountViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"佣金统计";
    
    self.countView = [[CommisionCountView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:self.countView];
    
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        [self requestCommisionCountByMonthOrYear:@"year"];
        [self requestCommisionCountByMonthOrYear:@"month"];
        
        [self requestOpenCountByMonthOrYear:@"year"];
        [self requestOpenCountByMonthOrYear:@"month"];
    }    
}

//佣金统计
- (void)requestCommisionCountByMonthOrYear:(NSString *)string{
    __block __weak CommisionCountViewController *weakself = self;

    [WebUtils requestCommissionCountWithDate:string andCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                
                if ([string isEqualToString:@"year"]) {
                    NSMutableArray *yearCountArray = [NSMutableArray array];
                    NSMutableArray *yearArray = [NSMutableArray array];
                    NSArray *array = obj[@"data"][@"commissionsList"];
//                    NSString *dateString = [Utils getLastMonth];
//                    dateString = [dateString componentsSeparatedByString:@" "].firstObject;
                    for (NSDictionary *dic in array) {
                        
                        [yearCountArray addObject:dic[@"commission"]];
                        [yearArray addObject:dic[@"time"]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        CGFloat max = [obj[@"data"][@"max"] floatValue];
                        
                        CGFloat average = [obj[@"data"][@"average"] floatValue];
                        
                        weakself.countView.countView.average2 = average;
                        weakself.countView.countView.max2 = max;
                        
                        weakself.countView.countView.accountsOpendCountYearArr = yearCountArray;
                        weakself.countView.countView.accountsOpenedYearArr = yearArray;
                        [weakself.countView.countView setNeedsDisplay];
                    });

                }else{
                    //最多只有6个
                    
                    NSMutableArray *monthCountArray = [NSMutableArray array];
                    NSMutableArray *monthArray = [NSMutableArray array];
                    
                    NSArray *array = obj[@"data"][@"commissionsList"];
                    NSString *dateString = [Utils getLastMonth];
                    dateString = [dateString componentsSeparatedByString:@" "].firstObject;
                    for (NSDictionary *dic in array) {
                        NSString *monthString = [[NSString stringWithFormat:@"%@",dic[@"time"]] componentsSeparatedByString:@"-"].lastObject;
                        [monthCountArray addObject:dic[@"commission"]];
                        [monthArray addObject:monthString];
                        
                        
                        //显示佣金
                        if ([dateString containsString:dic[@"time"]]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                weakself.countView.inputView.textField.text = [NSString stringWithFormat:@"%@",dic[@"time"]];
                                weakself.countView.inputView.leftLabel.text = [NSString stringWithFormat:@"佣金：%@元",dic[@"commission"]];
                            });
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        CGFloat max = [obj[@"data"][@"max"] floatValue];
                        
                        CGFloat average = [obj[@"data"][@"average"] floatValue];
                        
                        weakself.countView.countView.average = average;
                        weakself.countView.countView.max = max;
                        
                        [Utils drawChartLineWithLineChart:weakself.countView.countView.lineChart andXArray:monthArray andYArray:monthCountArray andMax:max andAverage:average andTitle:@"金额"];

                        
                        weakself.countView.countView.accountsOpenedArr = monthCountArray;
                        weakself.countView.countView.accountsOpenedMonthArr = monthArray;
                        [weakself.countView.countView setNeedsDisplay];
                    });
                    
                    
                }

            }else{
                NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [Utils toastview:mes];
                });
            }
        }
    }];
}

//开户量
- (void)requestOpenCountByMonthOrYear:(NSString *)string{
    __block __weak CommisionCountViewController *weakself = self;

    [WebUtils requestOpenCountWithDate:string andCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                
                if ([string isEqualToString:@"year"]) {
                    NSMutableArray *yearCountArray = [NSMutableArray array];
                    NSMutableArray *yearArray = [NSMutableArray array];
                    NSArray *array = obj[@"data"][@"statisticsList"];
//                    NSString *dateString = [Utils getLastMonth];
//                    dateString = [dateString componentsSeparatedByString:@" "].firstObject;
                    for (NSDictionary *dic in array) {
                        
                        [yearCountArray addObject:dic[@"record"]];
                        [yearArray addObject:dic[@"time"]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        CGFloat max = [obj[@"data"][@"max"] floatValue];
                        
                        CGFloat average = [obj[@"data"][@"average"] floatValue];
                        
                        weakself.countView.countView2.average2 = average;
                        weakself.countView.countView2.max2 = max;
                        
                        weakself.countView.countView2.accountsOpendCountYearArr = yearCountArray;
                        weakself.countView.countView2.accountsOpenedYearArr = yearArray;
                        
                        [weakself.countView.countView2 setNeedsDisplay];
                    });
                    
                }else{
                    //最多只有6个
                    
                    NSMutableArray *monthCountArray = [NSMutableArray array];
                    NSMutableArray *monthArray = [NSMutableArray array];
                    
                    NSArray *array = obj[@"data"][@"statisticsList"];
//                    NSString *dateString = [Utils getLastMonth];
//                    dateString = [dateString componentsSeparatedByString:@" "].firstObject;
                    for (NSDictionary *dic in array) {
                        NSString *monthString = [[NSString stringWithFormat:@"%@",dic[@"time"]] componentsSeparatedByString:@"-"].lastObject;

                        [monthCountArray addObject:dic[@"record"]];
                        [monthArray addObject:monthString];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        CGFloat max = [obj[@"data"][@"max"] floatValue];
                        
                        CGFloat average = [obj[@"data"][@"average"] floatValue];
                        
                        weakself.countView.countView2.average = average;
                        weakself.countView.countView2.max = max;
                        
                        [Utils drawChartLineWithLineChart:weakself.countView.countView2.lineChart andXArray:monthArray andYArray:monthCountArray andMax:max andAverage:average andTitle:@"开户量"];
                        
                        
                        weakself.countView.countView2.accountsOpenedArr = monthCountArray;
                        weakself.countView.countView2.accountsOpenedMonthArr = monthArray;
                        [weakself.countView.countView2 setNeedsDisplay];
                    });
                }
                
            }else{
                NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [Utils toastview:mes];
                });
            }
        }
    }];
}

@end
