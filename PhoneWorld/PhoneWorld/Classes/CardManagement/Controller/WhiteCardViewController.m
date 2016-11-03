//
//  WhiteCardViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "WhiteCardViewController.h"
#import "WhiteCardView.h"
#import "WhitePhoneModel.h"

@interface WhiteCardViewController ()

@property (nonatomic) WhiteCardView *whiteCardView;
@property (nonatomic) NSMutableArray *randomPhoneNumbersArray;

@end

@implementation WhiteCardViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"号码选择";
    
    self.randomPhoneNumbersArray = [NSMutableArray array];
    
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    [self requestWhiteNumberPool];
    self.whiteCardView = [[WhiteCardView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.whiteCardView];
    
    __block __weak WhiteCardViewController *weakself = self;

    [self.whiteCardView setWhiteCardSelectCallBack:^(NSString *numberpool, NSString *numberType) {
        NSLog(@"numberpool ---- %@   numbertype ---- %@",numberpool,numberType);
        [weakself requestRandomNumbersWithNumberPool:numberpool andNumberType:numberType];
    }];
}

- (void)requestRandomNumbersWithNumberPool:(NSString *)numberpool andNumberType:(NSString *)numberType{
    __block __weak WhiteCardViewController *weakself = self;

    [WebUtils requestPhoneNumbersWithNumberPool:[numberpool intValue] andNumberType:numberType andCallBack:^(id obj) {
        if (obj) {
            NSString *codeStr = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([codeStr isEqualToString:@"10000"]) {
                NSArray *objArr = obj[@"numbers"];
                for (NSDictionary *dic in objArr) {
                    WhitePhoneModel *pModel = [[WhitePhoneModel alloc] initWithDictionary:dic error:nil];
                    [weakself.randomPhoneNumbersArray addObject:pModel];
                }
                weakself.whiteCardView.randomPhoneNumbers = weakself.randomPhoneNumbersArray;
                [weakself.whiteCardView.contentView reloadData];
                NSLog(@"白卡开户号码查询结果:%@",obj[@"mes"]);
            }
        }
    }];
}

- (void)requestWhiteNumberPool{
    __block __weak WhiteCardViewController *weakself = self;
    [WebUtils requestWhiteCardPhoneNumbersWithCallBack:^(id obj) {
        if (obj) {
            if ([obj[@"code"] isEqualToString:@"10000"]) {
                NSArray *numberPoolArr = obj[@"data"][@"numberpool"];
                weakself.whiteCardView.selectView.numberPoolArray = numberPoolArr;
                NSArray *numberTypeArr = obj[@"data"][@"numbetrType"];
                weakself.whiteCardView.selectView.numberTypeArray = numberTypeArr;
            }else{
                
            }
        }
    }];
}

@end
