//
//  MainNavigationController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MainNavigationController.h"

#import "RightItemView.h"
#import "MessageViewController.h"
#import "PersonalHomeViewController.h"

//#import "TopBarView.h"

@interface MainNavigationController ()
//@property (nonatomic) TopBarView *topBarView;
@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = MainColor;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.translucent = NO;
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

//    UIImageView *lineImageView = [self findHairlineImageViewUnder:self.navigationBar];
//    lineImageView.hidden = YES;
    
    
    //当管理页面为1的时候(只显示一级页面的时候才添加)
    if(self.viewControllers.count == 1){
        
        //得到显示的页面再添加按钮
        RightItemView *rightItemView = [[RightItemView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
//        RightItemView *rightItemView = [RightItemView sharedRightItemView];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
        [rightItemView.rightButton addTarget:self action:@selector(gotoMessagesVC) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = rightItem;
        rightItemView.redLabel.hidden = YES;
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *hidden = [ud objectForKey:@"redItem"];
        if (hidden) {
            if ([hidden isEqualToString:@"YES"]) {
                rightItemView.redLabel.hidden = YES;
            }else{
                rightItemView.redLabel.hidden = NO;
            }
        }else{
            rightItemView.redLabel.hidden = NO;
        }
        
        self.topViewController.navigationItem.rightBarButtonItem = rightItem;
        
        self.topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"individualCenter"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoPersonalHomeVC)];
    }
}

- (void)gotoMessagesVC{
    MessageViewController *messageVC = [MessageViewController new];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self pushViewController:messageVC animated:YES];
}

- (void)gotoPersonalHomeVC{
    PersonalHomeViewController *vc = [PersonalHomeViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushViewController:vc animated:YES];
}

@end
