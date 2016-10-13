//
//  OrderCheckViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneCashCheckViewController.h"
#import "PhoneCashCheckView.h"

@interface PhoneCashCheckViewController ()
@property (nonatomic) PhoneCashCheckView *phoneCashCheckView;
@end

@implementation PhoneCashCheckViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.phoneCashCheckView = [[PhoneCashCheckView alloc] init];
    [self.view addSubview:self.phoneCashCheckView];
    [self.phoneCashCheckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    __block __weak PhoneCashCheckViewController *weakself = self;
    [self.phoneCashCheckView setOrderCallBack:^(NSInteger tag) {
        //查询操作
        NSString *phoneNum = weakself.phoneCashCheckView.phoneTF.text;
        if([Utils isMobile:phoneNum]){
            
        }else{
            [Utils toastview:@"手机号格式不正确，请重新输入"];
        }
    }];
    
}

@end
