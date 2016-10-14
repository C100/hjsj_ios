//
//  ProposeViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ProposeViewController.h"
#import "ProposeView.h"

@interface ProposeViewController ()
@property (nonatomic) ProposeView *proposeView;
@end

@implementation ProposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.proposeView = [[ProposeView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.proposeView];
}

@end
