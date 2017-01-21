//
//  HomeViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "HomeJumpViewController.h"

#import "MessageViewController.h"
#import "PersonalHomeViewController.h"
#import "HomeScrollModel.h"

#import "RightItemView.h"

@interface HomeViewController ()

@property (nonatomic) NSMutableArray *scrollViewModels;
@property (nonatomic) NSMutableArray *imageUrlGroup;
@property (nonatomic) HomeView *homeView;
//轮播图
@property (nonatomic) SDWebImageManager *imageManager;
@property (nonatomic) NSMutableArray *imagesArray;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.scrollViewModels = [NSMutableArray array];
    self.imageUrlGroup = [NSMutableArray array];
    self.imagesArray = [NSMutableArray array];

    __block __weak HomeViewController *weakself = self;
    
    [self requestFirstPageNews];
    
        
    //区分用户等级
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *grade = [ud objectForKey:@"grade"];
    if ([grade isEqualToString:@"lev1"] || [grade isEqualToString:@"lev2"]) {
        //代理商 功能少
        [self requestOpenCountByMonthOrYear:@"year"];
        [self requestOpenCountByMonthOrYear:@"month"];
    }
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [weakself requestHomeScrollView];
        }else{
            weakself.imagesArray = [NSMutableArray array];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSInteger number = [ud integerForKey:@"scrollViewNumber"];
            
            for (int i = 0; i < number; i ++) {
                NSString *appendingString = [NSString stringWithFormat:@"/Documents/homeScrollView%d.arch",i];
                NSString *path = [NSHomeDirectory() stringByAppendingString:appendingString];
                NSData *imageData = [NSData dataWithContentsOfFile:path];
                
                if (imageData) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    [weakself.imagesArray addObject:image];
                }
            }
            weakself.homeView.imageScrollView.localizationImageNamesGroup = weakself.imagesArray;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    _homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 44 - 64)];
    [self.view addSubview:self.homeView];
    
    //点击轮播图跳转
    [self.homeView setHomeHeadScrollCallBack:^(NSInteger number) {
        HomeScrollModel *homeModel = weakself.scrollViewModels[number];
        NSString *urlString = [NSString stringWithFormat:@"%@",homeModel.jumpUrl];
        if (![urlString isEqualToString:@""]) {
            HomeJumpViewController *jumpVC = [[HomeJumpViewController alloc] init];
            jumpVC.url = homeModel.jumpUrl;
            jumpVC.hidesBottomBarWhenPushed = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.navigationController pushViewController:jumpVC animated:YES];
            });
        }
    }];
}

#pragma mark - Method

- (void)requestHomeScrollView{
    __block __weak HomeViewController *weakself = self;
    
    [WebUtils requestHomeScrollPictureWithCallBack:^(id obj) {
        weakself.imageUrlGroup = [NSMutableArray array];

        if ([obj[@"code"] isEqualToString:@"10000"]) {
            
            NSArray *models = obj[@"data"][@"carousel_Picture"];
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setInteger:models.count forKey:@"scrollViewNumber"];
            [ud synchronize];
            
            for (int i = 0; i < models.count; i ++) {
                NSDictionary *dic = models[i];
                [weakself.imageUrlGroup addObject:dic[@"url"]];
                HomeScrollModel *homeModel = [[HomeScrollModel alloc] initWithDictionary:dic error:nil];
                [weakself.scrollViewModels addObject:homeModel];
                
                
//                耗时操作  非常耗时
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    //做图片缓存
                    NSString *appendingString = [NSString stringWithFormat:@"/Documents/homeScrollView%d.arch",i];
                    NSString *path = [NSHomeDirectory() stringByAppendingString:appendingString];
                    NSData *imageData = [NSData dataWithContentsOfURL:homeModel.url];
                    
                    [imageData writeToFile:path atomically:YES];
                });
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.homeView.imageScrollView.imageURLStringsGroup = self.imageUrlGroup;
            });
        }else{
            NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [Utils toastview:mes];
            });
        }
    }];
}

//开户量
- (void)requestOpenCountByMonthOrYear:(NSString *)string{
    __block __weak HomeViewController *weakself = self;
    
    [WebUtils requestOpenCountWithDate:string andCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                
                if ([string isEqualToString:@"year"]) {
                    NSMutableArray *yearCountArray = [NSMutableArray array];
                    NSMutableArray *yearArray = [NSMutableArray array];
                    NSArray *array = obj[@"data"][@"statisticsList"];
                    for (NSDictionary *dic in array) {
                        
                        [yearCountArray addObject:dic[@"record"]];
                        [yearArray addObject:dic[@"time"]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        CGFloat max = [obj[@"data"][@"max"] floatValue];
                        
                        CGFloat average = [obj[@"data"][@"average"] floatValue];
                        
                        weakself.homeView.countView.average2 = average;
                        weakself.homeView.countView.max2 = max;
                        
                        weakself.homeView.countView.accountsOpendCountYearArr = yearCountArray;
                        weakself.homeView.countView.accountsOpenedYearArr = yearArray;
                        [weakself.homeView.countView setNeedsDisplay];
                    });
                    
                }else{
                    //最多只有6个
                    
                    NSMutableArray *monthCountArray = [NSMutableArray array];
                    NSMutableArray *monthArray = [NSMutableArray array];
                    
                    NSArray *array = obj[@"data"][@"statisticsList"];
                    for (NSDictionary *dic in array) {
                        NSString *monthString = [[NSString stringWithFormat:@"%@",dic[@"time"]] componentsSeparatedByString:@"-"].lastObject;
                        
                        [monthCountArray addObject:dic[@"record"]];
                        [monthArray addObject:monthString];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        CGFloat max = [obj[@"data"][@"max"] floatValue];
                        
                        CGFloat average = [obj[@"data"][@"average"] floatValue];
                        
                        weakself.homeView.countView.average = average;
                        weakself.homeView.countView.max = max;
                        
                        [Utils drawChartLineWithLineChart:weakself.homeView.countView.lineChart andXArray:monthArray andYArray:monthCountArray andMax:max andAverage:average andTitle:@"开户量"];
                        
                        
                        weakself.homeView.countView.accountsOpenedArr = monthCountArray;
                        weakself.homeView.countView.accountsOpenedMonthArr = monthArray;
                        [weakself.homeView.countView setNeedsDisplay];
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

//请求消息中心数据，对比做小红点显示
- (void)requestFirstPageNews{
    int linage = (screenHeight-64)/40.0;
    NSString *linageString = [NSString stringWithFormat:@"%d",linage];
    [WebUtils requestMessageListWithLinage:linageString andPage:@"1" andCallBack:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
        if(obj){
            if([code isEqualToString:@"10000"]){
                
                NSArray *noticeArray = obj[@"data"][@"notice"];
                NSDictionary *newsDic = noticeArray.firstObject;
                
                NSString *latestNewsDateString = [[newsDic  objectForKey:@"updateDate"] componentsSeparatedByString:@"."].firstObject;
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                
                NSString *beforeNewsDateString = [ud objectForKey:@"latestNews"];//先得到之前的再同步
                
                BOOL isClickedNewsCenter = [ud boolForKey:@"isClickedNewsCenter"];
                
                [ud setObject:latestNewsDateString forKey:@"latestNews"];
                [ud synchronize];
                
                if (beforeNewsDateString) {
                    //对比现在得到的和之前保存的新闻日期
                    int result = [Utils compareDateWithNewDate:latestNewsDateString andOldDate:beforeNewsDateString];
                    
                    
                    switch (result) {
                        case 0:
                        {
                            if (isClickedNewsCenter) {
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"readNotification" object:nil];
                            }else{
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"unreadNotification" object:nil];
                            }
                            //一样
                        }
                            break;
                        case 1:
                        {
                            //new大
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"unreadNotification" object:nil];
                        }
                            break;
                        case -1:
                        {
                            //old大
                            if (isClickedNewsCenter) {
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"readNotification" object:nil];
                            }else{
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"unreadNotification" object:nil];
                            }

                        }
                            break;
                    }
                    
                    
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"unreadNotification" object:nil];
                }
                
                //正确
                int count = [obj[@"data"][@"count"] intValue];
                
                if (count == 0) {
                    
                }else{
                    
                }
            }else{
                
            }
        }
    }];
}


@end
