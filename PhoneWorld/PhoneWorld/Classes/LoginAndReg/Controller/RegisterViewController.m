//
//  RegisterViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"

@interface RegisterViewController ()
@property (nonatomic) RegisterView *registerView;
@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.registerView = [[RegisterView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.registerView];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardStateChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

@end
