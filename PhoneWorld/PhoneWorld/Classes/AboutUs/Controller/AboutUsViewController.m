//
//  AboutUsViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsView.h"

@interface AboutUsViewController ()
@property (nonatomic) AboutUsView *aboutUsView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.aboutUsView = [[AboutUsView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.aboutUsView];
    [self requestAboutUs];
}

- (void)requestAboutUs{
    __block __weak AboutUsViewController *weakself = self;

    [WebUtils requestAboutUsWithCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                NSString *information = [NSString stringWithFormat:@"%@",obj[@"data"][@"information"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.aboutUsView.aboutUsTV.text = information;
                });
            }else{
                NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [Utils toastview:mes];
                });
            }
        }
    }];
}

@end
