//
//  MessageDetailViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetailScrollView.h"
#import "MessageDetailModel.h"

@interface MessageDetailViewController ()
@property (nonatomic) MessageDetailScrollView *detailView;
@property (nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息详情";
    self.view.backgroundColor = COLOR_BACKGROUND;
    self.detailView = [[MessageDetailScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.detailView];
    
    __block __weak MessageDetailViewController *weakself = self;
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.frame = CGRectMake(0, 0, 100, 100);
    self.indicatorView.center = CGPointMake(screenWidth/2, (screenHeight-64)/2);
    [self.view addSubview:self.indicatorView];
    [self.indicatorView setHidesWhenStopped:YES];
    [self.indicatorView startAnimating];
    
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        [WebUtils requestMessageDetailWithId:self.message_id andCallBack:^(id obj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.indicatorView stopAnimating];
            });
            if (obj) {
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    NSDictionary *dic = obj[@"data"];
                    MessageDetailModel *detailModel = [[MessageDetailModel alloc] initWithDictionary:dic error:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.detailView.detailModel = detailModel;
                    });
                }
            }
        }];
    }
}

@end
