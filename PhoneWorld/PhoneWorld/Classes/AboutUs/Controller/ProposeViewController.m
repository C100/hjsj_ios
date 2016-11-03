//
//  ProposeViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ProposeViewController.h"
#import "ProposeView.h"
#import "FailedView.h"

@interface ProposeViewController ()
@property (nonatomic) ProposeView *proposeView;
@property (nonatomic) FailedView *resultView;
@end

@implementation ProposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.proposeView = [[ProposeView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.proposeView];
    
    __block __weak ProposeViewController *weakself = self;

    [self.proposeView setProposeCallBack:^(NSString *propose) {
        
        NSLog(@"----------上传建议意见：%@--------",propose);
        
        [WebUtils requestSuggestWithContent:propose andCallBack:^(id obj) {
            if(obj){
                if ([obj[@"code"] isEqualToString:@"10000"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.resultView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"多谢配合" andDetail:@"您的建议意见已收到，会尽快处理！" andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
                        [[UIApplication sharedApplication].keyWindow addSubview:weakself.resultView];
                        [NSTimer scheduledTimerWithTimeInterval:0.5 target:weakself selector:@selector(dismissResultView) userInfo:nil repeats:NO];
                        
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:@"上传失败"];
                    });
                }
                
            }
        }];
        
    }];
}

- (void)dismissResultView{
    [UIView animateWithDuration:1.0 animations:^{
        self.resultView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.resultView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
