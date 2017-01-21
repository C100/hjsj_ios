//
//  BlueManager.h
//  STIDCardDemo
//
//  Created by lili on 16/3/31.
//  Copyright (c) 2016年 lili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <STIDCardReader/STIDCardReader.h>
#import <STIDCardReader/STMyPeripheral.h>

@protocol BlueManagerDelegate;

@interface BlueManager : NSObject
@property (assign)id <BlueManagerDelegate> deleagte;
@property (nonatomic,retain) STMyPeripheral *linkedPeripheral;
+(id)instance;
+(void)releaseInstance;

//开始扫描
-(void)startScan;
- (void)stopScan;

-(void)connectPeripher:(STMyPeripheral *)peripheral;
- (void)disConnectPeripher:(STMyPeripheral *)peripheral;



@end

@protocol BlueManagerDelegate <NSObject>
//蓝牙扫描回调
- (void)didFindNewPeripheral:(STMyPeripheral *)periperal;

//连接设备的回调，成功 error为nil
- (void)connectperipher:(STMyPeripheral *)peripheral withError:(NSError *)error;

@end