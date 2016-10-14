//
//  FinishCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "FinishCardViewController.h"
#import "FinishCardView.h"

@interface FinishCardViewController ()
@property (nonatomic) FinishCardView *finishCardView;
@end

@implementation FinishCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成卡开户";
    self.view.backgroundColor = [UIColor whiteColor];
    self.finishCardView = [[FinishCardView alloc] init];
    [self.view addSubview:self.finishCardView];
    [self.finishCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

@end
