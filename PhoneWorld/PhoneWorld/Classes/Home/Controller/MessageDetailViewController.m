//
//  MessageDetailViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetailView.h"
#import "MessageDetailModel.h"

@interface MessageDetailViewController ()
@property (nonatomic) MessageDetailView *detailView;
@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息详情";
    self.view.backgroundColor = [UIColor greenColor];
    self.detailView = [[MessageDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.detailView];
    
    [WebUtils requestMessageDetailWithId:self.message_id andCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                MessageDetailModel *detailModel = [[MessageDetailModel alloc] initWithDictionary:obj[@"data"] error:nil];
            }
        }
    }];
    
}

@end
