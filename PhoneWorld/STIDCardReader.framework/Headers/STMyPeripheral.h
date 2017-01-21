//
//  STMyPeripheral.h
//  BLETR
//
//  Created by D500 user on 13/5/30.
//  Copyright (c) 2013年 ISSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface STMyPeripheral:NSObject
@property(nonatomic,retain) NSString *advName;
@property (nonatomic,retain)NSString *mac;

@property (nonatomic,retain) CBPeripheral *peripheral;
//Proprietary 读写特征值
@property(nonatomic,retain) CBCharacteristic *transparentDataWriteChar;
@property(nonatomic,retain) CBCharacteristic *transparentDataReadChar;

- (id)initWithCBPeripheral:(CBPeripheral *)peripheral;

@end


@interface STIDReadCardInfo : NSObject
@property (nonatomic)   int *isWhiteCard;           //=-1:读卡失败 ＝0:是白卡 ＝1:是成卡
@property (nonatomic,retain)    NSString *ICCID;    //=iccid号码成功 失败＝nil
@property (nonatomic,retain)    NSString *CARDTYPE; //暂未使用
@property (nonatomic)   int *writeCardResult;       //=0:写卡失败 ＝1:写卡成功
@property (nonatomic) int *messageResult;           //＝0:写短信中心号码失败 ＝1:成功
@property (retain) STMyPeripheral *currentPeripheral;  //连接蓝牙的句柄
@end


