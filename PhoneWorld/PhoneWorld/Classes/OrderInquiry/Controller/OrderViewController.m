//
//  OrderViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderViewController.h"
#import "TopView.h"
#import "ContentView.h"
#import "MessageViewController.h"
#import "PersonalHomeViewController.h"
#import "FilterView.h"

#define selectV 220/375.0

static OrderViewController *_orderViewController;

@interface OrderViewController ()<UIScrollViewDelegate>

@property (nonatomic) FilterView *selectView;//筛选new

@property (nonatomic) TopView *topView;//标题栏
@property (nonatomic) UIView *grayView;//灰色
@property (nonatomic) UITapGestureRecognizer *tapGrayGR;

@property (nonatomic) ContentView *contentScrollView;

@end

@implementation OrderViewController
#pragma mark - LifeCircle

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

+ (OrderViewController *)shareOrderViewController{
    if (!_orderViewController) {
        _orderViewController = [[OrderViewController alloc] init];
    }
    return _orderViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"individualCenter"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoPersonalHomeVC)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"news_white"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMessagesVC)];
    
    /*----top栏-----*/
    self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 80) andTitles:@[@"成卡开户",@"白卡开户",@"过户",@"补卡",@"充值"]];
    [self.view addSubview:self.topView];
    
    /*---内容--*/
    self.contentScrollView = [[ContentView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, screenHeight - 108 - 80)];
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_equalTo(44);
    }];
    self.contentScrollView.delegate = self;
    
    [self grayView];
    
    /*-----筛选框new--------*/
    self.selectView = [[FilterView alloc] initWithFrame:CGRectMake(0, 81, screenWidth, 240)];
    self.selectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectView];
    self.selectView.hidden = YES;
    self.selectView.orderStates = @[@"全部",@"已激活",@"锁定",@"开户中",@"已使用",@"失效"];

    
    __block __weak OrderViewController *weakself = self;
    [self.topView setCallback:^(NSInteger tag) {
        /*---按钮点击事件---*/
        
        switch (tag) {
            case 101:{//出现筛选框按钮
                [UIView animateWithDuration:0.5 animations:^{
                    if (weakself.selectView.hidden == NO) {
                        weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
                    }else{
                        weakself.topView.showButton.transform = CGAffineTransformIdentity;
                    }
                    weakself.selectView.hidden = weakself.selectView.hidden == YES ? NO:YES;
                    weakself.grayView.hidden = weakself.grayView.hidden == YES ? NO:YES;
                }];
            }
                break;
                
            default:{
                //10 11 12 13 14
                [weakself.contentScrollView setContentOffset:CGPointMake(screenWidth*(tag - 10), 0)];
            }
                break;
        }
        
    }];
    
    [self.topView setTopCallBack:^(id obj) {
        [UIView animateWithDuration:0.5 animations:^{
            if (weakself.selectView.hidden == NO) {
                weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
            }else{
                weakself.topView.showButton.transform = CGAffineTransformIdentity;
            }
            weakself.selectView.hidden = weakself.selectView.hidden == YES ? NO:YES;
            weakself.grayView.hidden = weakself.grayView.hidden == YES ? NO:YES;
        }];
    }];
    
}

#pragma mark - Method
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

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/screenWidth;
    for (UIButton *b in self.topView.titlesButton) {
        b.selected = NO;
    }
    UIButton *btn = self.topView.titlesButton[page];
    btn.selected = YES;
    self.selectView.titles = @[@"起始时间",@"截止时间",@"订单状态",@"手机号码"];
    self.selectView.details = @[@"请选择",@"请选择",@"请选择",@"请输入手机号码"];
    //筛选new
    if (page == 0 || page == 1) {
        self.selectView.orderStates = @[@"全部",@"已激活",@"锁定",@"开户中",@"已使用",@"失效"];
    }
    
    if (page == 2 || page == 3) {
        self.selectView.orderStates = @[@"全部",@"待审核",@"审核通过",@"审核不通过"];
    }
    
    if (page == 4) {//充值
        self.selectView.orderStates = @[@"全部",@"成功",@"失败",@"待定",@"出错"];
        self.selectView.titles = @[@"起始时间",@"截止时间",@"订单状态",@"充值类型"];
        self.selectView.details = @[@"请选择",@"请选择",@"请选择",@"请选择"];
    }
    [self.selectView.filterTableView reloadData];

}

#pragma mark - LazyLoading
- (UIView *)grayView{
    if (_grayView == nil) {
        _grayView = [[UIView alloc] init];
        [self.view addSubview:_grayView];
        _grayView.backgroundColor = [UIColor lightGrayColor];
        _grayView.alpha = 0.5;
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(screenHeight - 108 - 80 - 220);
        }];
        _grayView.hidden = YES;
        [_grayView addGestureRecognizer:self.tapGrayGR];
    }
    return _grayView;
}

- (UITapGestureRecognizer *)tapGrayGR{
    if (_tapGrayGR == nil) {
        _tapGrayGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    }
    return _tapGrayGR;
}

#pragma mark - Method
- (void)tapAction{
    [self.view endEditing:YES];
    __block __weak OrderViewController *weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (weakself.selectView.hidden == NO) {
            weakself.selectView.hidden = YES;
            weakself.grayView.hidden = YES;
        }else{
            weakself.selectView.hidden = NO;
            weakself.grayView.hidden = NO;
        }
    }];
}

@end
