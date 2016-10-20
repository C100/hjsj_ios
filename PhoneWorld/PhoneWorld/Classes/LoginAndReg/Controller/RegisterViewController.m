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

//- (void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    
//    [IQKeyboardManager sharedManager].enable = NO;
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    
//    [super viewWillDisappear:animated];
//    
//    [IQKeyboardManager sharedManager].enable = YES;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.registerView = [[RegisterView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.registerView];
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardStateChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - Method
//- (void)keyboardStateChanged:(NSNotification *)sender{
//    NSTimeInterval duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    CGRect rect = [sender.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    UIViewAnimationOptions option = [sender.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
//    CGFloat height = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
//    [UIView animateWithDuration:duration delay:0 options:option animations:^{
//        [self.registerView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(height);
//        }];
//        [self.view layoutIfNeeded];
//    } completion:nil];
//}

@end
