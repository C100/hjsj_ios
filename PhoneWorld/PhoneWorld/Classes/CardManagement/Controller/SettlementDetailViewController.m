//
//  SettlementDetailViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "SettlementDetailViewController.h"
#import "SettlementDetailView.h"
#import "FailedView.h"

@interface SettlementDetailViewController ()
@property (nonatomic) SettlementDetailView *detailView;
@property (nonatomic) FailedView *finishedView;
@property (nonatomic) NSString *sumMoney;
@property (nonatomic) FailedView *processView;
@end

@implementation SettlementDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算明细";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textfont14]} forState:UIControlStateNormal];

    self.detailView = [[SettlementDetailView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.detailView];
    
    [self requestAllMoney];
    
    NSArray *titlesArray = @[@"开户号码：",@"预存金额：",@"套餐金额：",@"活动包："];
    
    if (self.isFinished == YES) {
        //成卡
        
        for (int i = 0; i < self.detailView.leftLabelsArray.count; i ++) {
            UILabel *lb = self.detailView.leftLabelsArray[i];
            switch (i) {
                case 0://开户号码
                {
                    lb.text = [NSString stringWithFormat:@"%@%@",titlesArray[i],self.detailModel.number];
                }
                    break;
                case 1://预存金额
                {
                    lb.text = [NSString stringWithFormat:@"%@%@",titlesArray[i],self.moneyString];
                }
                    break;
                case 3://活动包
                {
                    lb.text = [NSString stringWithFormat:@"%@%@",titlesArray[i],self.currentPromotionDictionary[@"name"]];
                }
                    break;
            }
        }
        
    }else{
        //白卡
        
        for (int i = 0; i < self.detailView.leftLabelsArray.count; i ++) {
            UILabel *lb = self.detailView.leftLabelsArray[i];
            switch (i) {
                case 0://开户号码
                {
                    lb.text = [NSString stringWithFormat:@"%@%@",titlesArray[i],self.infosArray.firstObject];
                }
                    break;
                case 1://预存金额
                {
                    lb.text = [NSString stringWithFormat:@"%@%@",titlesArray[i],self.moneyString];
                }
                    break;
                case 3://活动包
                {
                    lb.text = [NSString stringWithFormat:@"%@%@",titlesArray[i],self.currentPromotionDictionary[@"name"]];
                }
                    break;
            }
        }
        
        
    }
    
    __block __weak SettlementDetailViewController *weakself = self;

    [self.detailView setSubmitCallBack:^(id obj) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.processView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"正在提交" andDetail:@"请耐心等待..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
            [[UIApplication sharedApplication].keyWindow addSubview:weakself.processView];
        });
        
        if (weakself.isFinished == YES) {
            /*----成卡开户------*/
            
            
            NSMutableDictionary *sendDictionary = [weakself.collectionInfoDictionary mutableCopy];
            
            [sendDictionary setObject:weakself.detailModel.number forKey:@"number"];
            NSString *autoString = @"手工";
            if (weakself.isAuto) {
                autoString = @"自动";
            }
            [sendDictionary setObject:autoString forKey:@"authenticationType"];
            NSString *simid = [NSString stringWithFormat:@"%d",weakself.detailModel.simId];
            [sendDictionary setObject:simid forKey:@"simId"];
            [sendDictionary setObject:weakself.detailModel.simICCID forKey:@"simICCID"];
            [sendDictionary setObject:weakself.currentPackageDictionary[@"id"] forKey:@"packageId"];
            [sendDictionary setObject:weakself.currentPromotionDictionary[@"id"] forKey:@"promotionsId"];
            [sendDictionary setObject:weakself.sumMoney forKey:@"orderAmount"];
            NSString *orgId = [NSString stringWithFormat:@"%d",weakself.detailModel.org_number_poolsId];
            [sendDictionary setObject:orgId forKey:@"org_number_poolsId"];
            
            //提交操作
            [WebUtils requestSetOpenWithDictionary:sendDictionary andcallBack:^(id obj) {
                if (obj) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //提示框删除
                        [weakself.processView removeFromSuperview];
                    });
                    
                    NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                    if ([code isEqualToString:@"10000"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            weakself.finishedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"提交成功" andDetail:@"请耐心等待..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
                            [[UIApplication sharedApplication].keyWindow addSubview:weakself.finishedView];
                            
                            [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(removeGrayView) userInfo:nil repeats:NO];
                        });
                        
                        
                    }else{
                        if (![code isEqualToString:@"39999"]) {
                            NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [Utils toastview:mes];
                            });
                        }
                    }
                }
            }];

            /*----成卡开户---*/
            
        }else if(weakself.isFinished == NO){
            /*------白卡开户------*/
            
            NSMutableDictionary *sendDictionary = [weakself.collectionInfoDictionary mutableCopy];
            
            [sendDictionary setObject:weakself.infosArray.firstObject forKey:@"number"];
            
            NSString *simid = [NSString stringWithFormat:@"%@",weakself.imsiModel.simId];
            [sendDictionary setObject:simid forKey:@"simId"];
            
            [sendDictionary setObject:weakself.iccidString forKey:@"iccid"];
            
            [sendDictionary setObject:weakself.imsiModel.imsi forKey:@"imsi"];
            
            NSNumber *orderAmount = [NSNumber numberWithInt:weakself.imsiModel.prestore];
            [sendDictionary setObject:orderAmount forKey:@"orderAmount"];
            
            [sendDictionary setObject:weakself.currentPackageDictionary[@"id"] forKey:@"packageId"];
            [sendDictionary setObject:weakself.currentPromotionDictionary[@"id"] forKey:@"promotionsId"];
            
            [sendDictionary setObject:weakself.sumMoney forKey:@"payAmount"];
            
            [WebUtils requestOpenWhiteWithDictionary:sendDictionary andCallBack:^(id obj) {
                if (obj) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakself.processView removeFromSuperview];
                    });
                    NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                    if ([code isEqualToString:@"10000"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            weakself.finishedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"提交成功" andDetail:@"请耐心等待..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
                            [[UIApplication sharedApplication].keyWindow addSubview:weakself.finishedView];
                            
                            [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(removeGrayView) userInfo:nil repeats:NO];
                        });
                        
                        
                    }else{
                        if (![code isEqualToString:@"39999"]) {
                            NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [Utils toastview:mes];
                            });
                        }
                        
                    }
                }
            }];
            
            /*------白卡开户------*/
        }
        
    }];
    
}

//得到总金额
- (void)requestAllMoney{
    __block __weak SettlementDetailViewController *weakself = self;

    [WebUtils requestMoneyInfoWithPrestore:weakself.moneyString andPromotionId:weakself.currentPromotionDictionary[@"id"] andCallBack:^(id obj) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                //得到总金额
                NSString *sumString = [NSString stringWithFormat:@"%@",obj[@"data"][@"sum"]];
                UILabel *lb = weakself.detailView.leftLabelsArray.lastObject;
                
                //套餐金额与总金额一致
                UILabel *lbMoney = weakself.detailView.leftLabelsArray[2];
                
                weakself.sumMoney = sumString;
                
                //得到优惠金额
                NSInteger money = weakself.moneyString.integerValue;
                NSInteger sumMoney = sumString.integerValue;
                UILabel *labelDiscount = weakself.detailView.leftLabelsArray[4];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    lb.text = [NSString stringWithFormat:@"总金额：%@",sumString];
                    lbMoney.text = [NSString stringWithFormat:@"套餐金额：%@",sumString];
                    labelDiscount.text = [NSString stringWithFormat:@"优惠金额：%ld",money - sumMoney];
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


- (void)removeGrayView{
    [UIView animateWithDuration:0.5 animations:^{
        self.finishedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.finishedView removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}


- (void)cancelAction{
    /*
     不保存信息并返回首页
     */
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
