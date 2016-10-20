//
//  PhoneNumberCheckViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneNumberCheckViewController.h"
#import "PhoneNumberCheckView.h"

@interface PhoneNumberCheckViewController ()
@property (nonatomic) PhoneNumberCheckView *checkView;
@end

@implementation PhoneNumberCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机号码验证";
    self.checkView = [[PhoneNumberCheckView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.checkView];
}

@end
