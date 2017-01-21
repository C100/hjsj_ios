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
#import "ReadCardAndChoosePackageViewController.h"
#import "NormalTableViewCell.h"

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
    self.whiteCardView = [[WhiteCardView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.whiteCardView];
    
    [self requestWhiteNumberPool];
    
    __block __weak WhiteCardViewController *weakself = self;
    
    [self.whiteCardView setWhiteCardSelectCallBack:^(NSString *numberpool, NSString *numberType) {
        [weakself requestRandomNumbersWithNumberPool:numberpool andNumberType:numberType];
    }];
    
    
    [self.whiteCardView setChangeCallBack:^(id obj) {
        //换一批,就是用同一个方法再请求一遍，后台返回的数据就是随便的数据
        
        [weakself requestRandomNumbersWithNumberPool:weakself.whiteCardView.selectView.currentPoolId andNumberType:weakself.whiteCardView.selectView.currentType];
        
    }];
    
    [self.whiteCardView setNextCallBack:^(id obj) {
        //下一步
        
        ReadCardAndChoosePackageViewController *vc = [[ReadCardAndChoosePackageViewController alloc] init];
        vc.infos = @[weakself.whiteCardView.currentCell.phoneLB.text];
        vc.currentPoolId = weakself.whiteCardView.selectView.currentPoolId;
        vc.currentType = weakself.whiteCardView.selectView.currentType;
        [weakself.navigationController pushViewController:vc animated:YES];

        
    }];
    
    
}

//根据号码池和靓号规则返回随机号码
- (void)requestRandomNumbersWithNumberPool:(NSString *)numberpool andNumberType:(NSString *)numberType{
    __block __weak WhiteCardViewController *weakself = self;
    self.randomPhoneNumbersArray = [NSMutableArray array];
    [WebUtils requestPhoneNumbersWithNumberPool:[numberpool intValue] andNumberType:numberType andCallBack:^(id obj) {
        if (obj) {
            NSString *codeStr = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([codeStr isEqualToString:@"10000"]) {
                if ([obj[@"data"][@"numbers"] isKindOfClass:[NSNull class]]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [Utils toastview:@"没有数据"];
                        weakself.whiteCardView.randomPhoneNumbers = @[];
                        [weakself.whiteCardView.contentView reloadData];
                    });
                    
                }else{
                    NSArray *objArr = obj[@"data"][@"numbers"];
                    if (objArr.count == 0) {
                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [Utils toastview:@"没有数据"];
                            weakself.whiteCardView.randomPhoneNumbers = @[];
                            [weakself.whiteCardView.contentView reloadData];
                        });
                    }else if(objArr.count > 0){
                        for (NSDictionary *dic in objArr) {
                            WhitePhoneModel *pModel = [[WhitePhoneModel alloc] initWithDictionary:dic error:nil];
                            
                            pModel.pool = numberpool;
                            pModel.rules = numberType;
                            
                            [weakself.randomPhoneNumbersArray addObject:pModel];
                        }
                        weakself.whiteCardView.randomPhoneNumbers = weakself.randomPhoneNumbersArray;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakself.whiteCardView.contentView reloadData];
                        });
                    }
                }
            }else{
                NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [Utils toastview:mes];
                });
            }
        }
    }];
}

//返回号码池以及靓号规则
- (void)requestWhiteNumberPool{
    __block __weak WhiteCardViewController *weakself = self;
    [WebUtils requestWhiteCardPhoneNumbersWithCallBack:^(id obj) {
        if (obj) {
            if ([obj[@"code"] isEqualToString:@"10000"]) {
                NSArray *numberPoolArr = obj[@"data"][@"numberpool"];
                weakself.whiteCardView.selectView.numberPoolArray = numberPoolArr;
                NSArray *numberTypeArr = obj[@"data"][@"numbetrType"];
                weakself.whiteCardView.selectView.numberTypeArray = numberTypeArr;
                
                NSDictionary *poolDic = numberPoolArr.firstObject;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    /*--查询得到号码池和靓号规则之后用第一个--*/
                    
                    //默认筛选栏中就是第一个号码池和靓号规则
                    for (int i = 0; i < 2; i ++) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        NormalTableViewCell *cell = [weakself.whiteCardView.selectView.filterTableView cellForRowAtIndexPath:indexPath];
                        
                        if (i == 0) {
                            cell.detailLabel.text = [NSString stringWithFormat:@"%@",poolDic[@"name"]];
                        }else{
                            cell.detailLabel.text = [NSString stringWithFormat:@"%@",numberTypeArr.firstObject];
                        }
                    }
                    
                    weakself.whiteCardView.selectView.currentPoolId = poolDic[@"id"];
                    weakself.whiteCardView.selectView.currentType = numberTypeArr.firstObject;
                    
                    [weakself requestRandomNumbersWithNumberPool:poolDic[@"id"] andNumberType:numberTypeArr.firstObject];
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
