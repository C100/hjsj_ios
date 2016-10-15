//
//  TransferCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TransferCardViewController.h"
#import "TransferCardView.h"

@interface TransferCardViewController ()<UIScrollViewDelegate>
@property (nonatomic) TransferCardView *transferCardView;
@end

@implementation TransferCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"过户";
    self.view.backgroundColor = [UIColor whiteColor];
    self.transferCardView = [[TransferCardView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.transferCardView];
    self.transferCardView.delegate = self;
}

@end
