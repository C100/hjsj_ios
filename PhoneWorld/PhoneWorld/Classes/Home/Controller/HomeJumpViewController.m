//
//  HomeJumpViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/3.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "HomeJumpViewController.h"

@interface HomeJumpViewController ()<UIWebViewDelegate>

@property (nonatomic) UIWebView *webView;
@property (nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation HomeJumpViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.frame = CGRectMake(0, 0, 100, 100);
    self.indicatorView.center = CGPointMake(screenWidth/2, (screenHeight-64)/2);
    [self.view addSubview:self.indicatorView];
    [self.indicatorView setHidesWhenStopped:YES];
    [self.indicatorView startAnimating];

}

#pragma mark - UIWebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //加载结束时
    [self.indicatorView stopAnimating];
}


@end
