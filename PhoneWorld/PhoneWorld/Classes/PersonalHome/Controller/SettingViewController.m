//
//  SettingViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingView.h"
#import "AboutUsViewController.h"
#import "ProposeViewController.h"

@interface SettingViewController ()
@property (nonatomic) SettingView *settingView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.settingView = [[SettingView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:self.settingView];
    __block __weak SettingViewController *weakself = self;
    [self.settingView setSettingCallBack:^(NSInteger number) {
        switch (number) {
            case 0:
            {//意见反馈
                ProposeViewController *vc = [ProposeViewController new];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {//清除缓存
                [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
                    //开线程执行
                    NSString *message = [NSString stringWithFormat:@"您确认清除%.3fMB缓存",totalSize/1024.0/1024.0];
                    
                    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //清除内存缓存
                        [[SDImageCache sharedImageCache] clearMemory];
                        //清除磁盘缓存
                        [[SDImageCache sharedImageCache] clearDisk];
                    }];
                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [ac addAction:action1];
                    [ac addAction:action2];
                    [weakself presentViewController:ac animated:YES completion:nil];
                    
                }];
            }
                break;
            case 2:
            {//APP评分
                
            }
                break;
            case 3:
            {//关于我们
                AboutUsViewController *vc = [AboutUsViewController new];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }];
}

@end
