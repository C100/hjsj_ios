//
//  InformationCollectionViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "InformationCollectionViewController.h"
#import "InformationCollectionView.h"
#import "SettlementDetailViewController.h"

#import <STIDCardReader/STIDCardReader.h>//蓝牙读身份证
//#define ERROR
#define UDValue(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define SETUDValue(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]

#define SERVER @"SERVERIP"  //@"192.168.1.10"//@"222.134.70.138" //
#define PORT @"SERVERPORT" //10002//8088 //

#import "PopView.h"
#import "PersonCardModel.h"

@interface InformationCollectionViewController ()

@property (nonatomic) InformationCollectionView *informationCollectionView;
@property (nonatomic) BOOL isAuto;

@property (nonatomic) PopView *popView;//点击读取信息的时候弹出框显示所有搜索到的蓝牙
@property (nonatomic) PersonCardModel *personModel;//读出来的身份证信息

@end

@implementation InformationCollectionViewController


- (void)dealloc{
//    NSLog(@"------dealloc------hahaha");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息采集";
    self.isAuto = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"读取信息" style:UIBarButtonItemStylePlain target:self action:@selector(readInfoAction)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textfont14]} forState:UIControlStateNormal];
    
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.informationCollectionView = [[InformationCollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andIsFinished:self.isFinished];
    [self.view addSubview:self.informationCollectionView];
    
    self.informationCollectionView.chooseImageView.titleLabelsArray.firstObject.text = @"身份证正面\n+卡板号码照片";
    self.informationCollectionView.chooseImageView.titleLabelsArray.lastObject.text = @"本人手持身份证正面+卡板照片";
    
    __block __weak InformationCollectionViewController *weakself = self;

    [self.informationCollectionView setNextCallBack:^(NSDictionary *dic) {
        SettlementDetailViewController *viewController = [[SettlementDetailViewController alloc] init];
        
        if (weakself.isFinished == YES) {
            //成卡
            viewController.detailModel = weakself.detailModel;
            viewController.isFinished = YES;
        }else{
            //白卡
            viewController.isFinished = NO;
            viewController.imsiModel = weakself.imsiModel;
            viewController.iccidString = weakself.iccidString;
        }
        
        if (weakself.infosArray && weakself.infosArray.count > 0) {
            viewController.infosArray = weakself.infosArray;
        }
        viewController.currentPackageDictionary = weakself.currentPackageDictionary;
        viewController.currentPromotionDictionary = weakself.currentPromotionDictionary;
        viewController.collectionInfoDictionary = dic;
        viewController.moneyString = weakself.moneyString;
        viewController.isAuto = weakself.isAuto;
        [weakself.navigationController pushViewController:viewController animated:YES];
    }];
    
}

- (void)readInfoAction{
    __block __weak InformationCollectionViewController *weakself = self;

    //读卡+写卡（imsi+smscent）操作
    /*
     self.imsiModel.imsi
     self.imsiModel.smscent
     */
    self.isAuto = YES;
    
    [[STIDCardReader instance] setDelegate:self];
    
    self.popView = [[PopView alloc] init];
    [self.view addSubview:self.popView];
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    [self.popView setPopCallBack:^(id obj) {
        //点击popView黑色背景隐藏popView
        dispatch_async(dispatch_get_main_queue(), ^{
            [[BlueManager instance] stopScan];
            [weakself startScareCard];
            weakself.popView.hidden = YES;
        });
    }];
}

-(void)startScareCard{
    
    BlueManager *bmanager = [BlueManager instance];
    bmanager.deleagte = (id)self;
    if(bmanager.linkedPeripheral == nil){
        [Utils toastview:@"请先选中要连接的蓝牙设备!"];
    }else{
        if(bmanager.linkedPeripheral.peripheral.state != CBPeripheralStateConnected){
//            NSLog(@"蓝牙处于未连接状态,先连接蓝牙!");
            [[BlueManager instance] connectPeripher:bmanager.linkedPeripheral];
        }else{
//            NSLog(@"蓝牙处在连接状态,直接进行读卡的操作!");
            [[STIDCardReader instance] setDelegate:(id)self];
            [[STIDCardReader instance] startScaleCard];
        }
    }
    
}

//--MainVewi中断开蓝牙的连接，在读卡成功或者失败的时候都要执行断开的操作
/**
 * 关闭蓝牙连接的方法
 * 在调用该方法后，会关闭在蓝牙设备列表中选中的蓝牙设备的连接，但不会清除该对象！
 * 如果是连续读卡的环境或者想要更快的读卡速度，建议不要调用此方法，使蓝牙设备保持长连接。
 * 如果读卡业务不繁忙，可以在读完卡之后调用该方法，关闭蓝牙连接。
 */
-(void) disconnectCurrentPeripher:(STMyPeripheral *)peripheral{
//    NSLog(@"MainView进入断开蓝牙的操作!");
    if(peripheral.peripheral.state == CBPeripheralStateConnected){
//        NSLog(@"蓝牙处于连接状态,需要关闭!");
        BlueManager *bmanager = [BlueManager instance];
        bmanager.deleagte = (id)self;
        [bmanager disConnectPeripher:peripheral];
    }
}

#pragma ScaleDelegate
- (void)failedBack:(STMyPeripheral *)peripheral withError:(NSError *)error{
    
    if(error){
        
        //----出现错误之后,发送断开蓝牙的指令，如果想要保持长连接，可以不用关闭----
        //[self disconnectCurrentPeripher:peripheral];
        
        //--循环测试的方法,10秒之后循环读卡---
        [self performSelector:@selector(startScareCard) withObject:nil afterDelay:5.0f];
    }
}

- (void)successBack:(STMyPeripheral *)peripheral withData:(id)data{
    
    if(data && [data isKindOfClass:[NSDictionary class]]){
        
        for (int i = 0; i < self.informationCollectionView.inputViews.count; i ++) {
            InputView *inputView = self.informationCollectionView.inputViews[i];
            switch (i) {
                case 0:
                {
                    NSString *nameString = [[NSString stringWithFormat:@"%@",data[@"Name"]] componentsSeparatedByString:@" "].firstObject;
                    inputView.textField.text = nameString;
                }
                    break;
                case 1:
                {
                    NSString *cardNoString = [[NSString stringWithFormat:@"%@",data[@"CardNo"]] componentsSeparatedByString:@" "].firstObject;
                    inputView.textField.text = cardNoString;
                }
                    break;
                case 2:
                {
                    NSString *addressString = [[NSString stringWithFormat:@"%@",data[@"Address"]] componentsSeparatedByString:@" "].firstObject;
                    inputView.textField.text = addressString;
                }
                    break;
                case 3:
                {
//                    inputView.textField.text = [NSString stringWithFormat:@"读卡时的备注写什么？？？？？"];
                }
                    break;
            }
        }
        
        self.personModel = [[PersonCardModel alloc] initWithDictionary:data error:nil];
        
    }else if (data &&[data isKindOfClass:[NSData class]]){
        
        UIImage *img = [UIImage imageWithData:data];
        
        UIImageView *lastImageView = self.informationCollectionView.chooseImageView.imageViews.lastObject;
        lastImageView.hidden = NO;
        lastImageView.image = img;
        
        UIButton *removeButton = self.informationCollectionView.chooseImageView.removeButtons.lastObject;
        removeButton.hidden = NO;
        
        UIButton *addImageButton = self.informationCollectionView.chooseImageView.imageButtons.lastObject;
        addImageButton.userInteractionEnabled = NO;

//        ----照片解析出来之后，发送断开蓝牙的指令，如果想要保持长连接，可以不关闭蓝牙连接----
        [self disconnectCurrentPeripher:peripheral];
//        --循环测试的方法,10秒之后循环读卡---
//        [self performSelector:@selector(startAll) withObject:nil afterDelay:4.3f];
    }
    
}

@end
