//
//  MessageViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageView.h"
#import "MessageModel.h"

@interface MessageViewController ()

@property (nonatomic) NSInteger linage;
@property (nonatomic) NSInteger page;
@property (nonatomic) MessageView *messageView;
@property (nonatomic) NSMutableArray *messageArray;

@end

@implementation MessageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息中心";
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    self.linage = (screenHeight-64)/60;
    self.page = 1;
    
    self.messageView = [[MessageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.messageView];
    
    __block __weak MessageViewController *weakself = self;
    
    [self.messageView.messageTableView addPullToRefreshWithActionHandler:^{
        [weakself requestMessageList];
    }];
    
    [self.messageView.messageTableView addInfiniteScrollingWithActionHandler:^{
        [weakself requestMessageListMore];
    }];
    
    [self.messageView.messageTableView triggerPullToRefresh];
}

- (void)requestMessageList{
    __block __weak MessageViewController *weakself = self;
    self.page = 1;
    self.messageArray = [NSMutableArray array];
    NSLog(@"------linage = %ld-----page = %ld",self.linage,self.page);
    NSString *linageStr = [NSString stringWithFormat:@"%ld",self.linage];
    NSString *pageStr = [NSString stringWithFormat:@"%ld",self.page];
    [WebUtils requestMessageListWithLinage:linageStr andPage:pageStr andCallBack:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
        if(obj){
            if([code isEqualToString:@"10000"]){
                //正确
                NSArray *messageArr = obj[@"data"][@"notice"];
                for (NSDictionary *dic in messageArr) {
                    MessageModel *mm = [[MessageModel alloc] initWithDictionary:dic error:nil];
                    [weakself.messageArray addObject:mm];
                }
                weakself.messageView.messagesArray = weakself.messageArray;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.messageView.messageTableView reloadData];
                    
                    [weakself.messageView.messageTableView.pullToRefreshView stopAnimating];
                });
                
            }else{
                //查询错误
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakself.messageView.messageTableView.pullToRefreshView stopAnimating];
                });

            }
        }
    }];
}

//上拉加载
- (void)requestMessageListMore{
    __block __weak MessageViewController *weakself = self;
    self.page ++;
    NSLog(@"------linage = %ld-----page = %ld",self.linage,self.page);
    NSString *linageStr = [NSString stringWithFormat:@"%ld",self.linage];
    NSString *pageStr = [NSString stringWithFormat:@"%ld",self.page];
    [WebUtils requestMessageListWithLinage:linageStr andPage:pageStr andCallBack:^(id obj) {
        NSString *count = [NSString stringWithFormat:@"%@",obj[@"data"][@"count"]];
        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
        if(obj){
            if([count isEqualToString:@"0"]){
                //页码到头
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [Utils toastview:@"已经是最后一页"];
                    [weakself.messageView.messageTableView.infiniteScrollingView stopAnimating];
                });
                
            }else if([code isEqualToString:@"10000"] && ![count isEqualToString:@"0"]){
                //正确
                NSArray *messageArr = obj[@"data"][@"notice"];
                for (NSDictionary *dic in messageArr) {
                    MessageModel *mm = [[MessageModel alloc] initWithDictionary:dic error:nil];
                    [weakself.messageArray addObject:mm];
                }
                weakself.messageView.messagesArray = weakself.messageArray;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.messageView.messageTableView reloadData];
                    
                    [weakself.messageView.messageTableView.infiniteScrollingView stopAnimating];
                });
                
            }else{
                //查询错误
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weakself.messageView.messageTableView.infiniteScrollingView stopAnimating];
                });
                
            }
        }
    }];
}


@end
