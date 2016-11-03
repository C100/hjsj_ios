//
//  HomeViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"

#import "MessageViewController.h"
#import "PersonalHomeViewController.h"
#import "HomeScrollModel.h"

@interface HomeViewController ()

@property (nonatomic) NSMutableArray *scrollViewModels;
@property (nonatomic) NSMutableArray *imageUrlGroup;
@property (nonatomic) HomeView *homeView;

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

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"individualCenter"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoPersonalHomeVC)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"news_white"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMessagesVC)];
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.scrollViewModels = [NSMutableArray array];
    self.imageUrlGroup = [NSMutableArray array];
    
    [self requestHomeScrollView];
    
    _homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 44 - 64)];
    [self.view addSubview:self.homeView];
}

#pragma mark - Method

- (void)requestHomeScrollView{
    [WebUtils requestHomeScrollPictureWithCallBack:^(id obj) {
        if ([obj[@"code"] isEqualToString:@"10000"]) {
            NSArray *models = obj[@"data"][@"carousel_Picture"];
            for (NSDictionary *dic in models) {
                [self.imageUrlGroup addObject:dic[@"url"]];
                HomeScrollModel *homeModel = [[HomeScrollModel alloc] initWithDictionary:dic error:nil];
                [self.scrollViewModels addObject:homeModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.homeView.imageScrollView.imageURLStringsGroup = self.imageUrlGroup;
            });
        }else{
            NSLog(@"~~~~~~~~~~~首页轮播图请求失败~~~~~~~~~~~~");
        }
    }];
}

- (void)gotoMessagesVC{
    MessageViewController *messageVC = [MessageViewController new];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)gotoPersonalHomeVC{
    PersonalHomeViewController *vc = [PersonalHomeViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
