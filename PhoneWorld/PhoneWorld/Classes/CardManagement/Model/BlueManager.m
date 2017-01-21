//
//  BlueManager.m
//  STIDCardDemo
//
//  Created by lili on 16/3/31.
//  Copyright (c) 2016年 lili. All rights reserved.
//

#import "BlueManager.h"


//Device Info service
#define UUIDSTR_DEVICE_INFO_SERVICE             @"180A"
#define UUIDSTR_MANUFACTURE_NAME_CHAR           @"2A29"
#define UUIDSTR_MODEL_NUMBER_CHAR               @"2A24"
#define UUIDSTR_SERIAL_NUMBER_CHAR              @"2A25"
#define UUIDSTR_HARDWARE_REVISION_CHAR          @"2A27"
#define UUIDSTR_FIRMWARE_REVISION_CHAR          @"2A26"
#define UUIDSTR_SOFTWARE_REVISION_CHAR          @"2A28"
#define UUIDSTR_SYSTEM_ID_CHAR                  @"2A23"

#define UUIDSTR_ISSC_PROPRIETARY_SERVICE        @"49535343-FE7D-4AE5-8FA9-9FAFD205E455"
#define UUIDSTR_CONNECTION_PARAMETER_CHAR       @"49535343-6DAA-4D02-ABF6-19569ACA69FE"
#define UUIDSTR_AIR_PATCH_CHAR                  @"49535343-ACA3-481C-91EC-D85E28A60318"
#define UUIDSTR_ISSC_TRANS_TX                   @"49535343-1E4D-4BD9-BA61-23C647249616"
#define UUIDSTR_ISSC_TRANS_RX                   @"49535343-8841-43F4-A8D4-ECBE34729BB3"

//CBCentralManagerOptionRestoreIdentifierKey
#define ISSC_RestoreIdentifierKey               @"ISSC_RestoreIdentifierKey"

@interface BlueManager ()

@property CBCentralManager *cm;
@property (nonatomic,retain)NSTimer *connectTimer;
@property (nonatomic,retain)STMyPeripheral *curConnectPeripheral;

@end

@implementation BlueManager;
@synthesize deleagte;
@synthesize cm =_cm;
@synthesize connectTimer= _connectTimer;
@synthesize curConnectPeripheral;

static BlueManager *manager = nil;

+(id)instance{
    if(manager == nil){
        manager = [[BlueManager alloc] init];
    }
    return manager;
}

- (id)init{
    if(self= [super init]){
//        NSLog(@"进入Manager的init方法");
        _cm = [[CBCentralManager alloc] initWithDelegate:(id)self queue:nil];
    }
    return self;
}

+(void)releaseInstance{
    
    if(manager.cm){
        [manager.cm stopScan];
        manager.cm = nil;
    }
    manager = nil;
}

//开始扫描
-(void)startScan{
//    NSLog(@"开始扫描蓝牙设备");
    
    if(self.cm == nil){
        _cm = [[CBCentralManager alloc] initWithDelegate:(id)self queue:nil];
    }
    
    
    //[self.cm stopScan];
    //根据设备的特有特征值 可传入设备独有的参数
    //    NSArray *services = @[@"49535343-FE7D-4AE5-8FA9-9FAFD205E455"];
    //    [self.cm scanForPeripheralsWithServices:services options:@{CBCentralManagerScanOptionAllowDuplicatesKey: [NSNumber numberWithBool:NO]}];
    //扫描所有蓝牙设备
    
    
    if([self.cm state] == CBCentralManagerStatePoweredOn){
//        NSLog(@"蓝牙start scan");
        //[self.cm scanForPeripheralsWithServices:nil options:nil];
        [self.cm scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey: [NSNumber numberWithBool:NO]}];
    }else{
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
//            NSLog(@"蓝牙服务尚未启动");
            [Utils toastview:@"请打开手机蓝牙"];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startScan];
        });
    }
    
}

- (void)stopScan{
    if(self.cm){
        [self.cm stopScan];
    }
}

- (void)connectTimeout:(STMyPeripheral *)peripher{
    
    NSError *error = [NSError errorWithDomain:@"蓝牙连接超时" code:-7 userInfo:nil];
//    NSLog(@"蓝牙连接超时");
    
    [Utils toastview:@"蓝牙连接超时"];
    
    if(self.deleagte && [self.deleagte respondsToSelector:@selector(connectperipher:withError:)]){
        [self.deleagte connectperipher:peripher withError:error];
    }
}


-(void)connectPeripher:(STMyPeripheral *)peripheral{
    if(peripheral){
        
        self.curConnectPeripheral = peripheral;
        self.linkedPeripheral = peripheral;
        [self.cm connectPeripheral:peripheral.peripheral options:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey: [NSNumber numberWithBool:YES]}];
        
        self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:20.0f target:self selector:@selector(connectTimeout:) userInfo:peripheral repeats:NO];
         //self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:20.0f target:self selector:@selector(connectTimeout:) userInfo:nil repeats:NO];
    }
}


- (void)disConnectPeripher:(STMyPeripheral *)peripheral{
    
    if(peripheral && peripheral.peripheral){        
        [self.cm cancelPeripheralConnection: peripheral.peripheral];
    }
    
}


///蓝牙delegate
- (void) centralManagerDidUpdateState:(CBCentralManager *)central{
    
//    NSString * state = nil;
    BOOL isOk = NO;
    switch ([self.cm state]){
        case CBCentralManagerStateUnsupported:
//            state = @"设备未提供蓝牙服务.";
            break;
        case CBCentralManagerStateUnauthorized:
//            state = @"软件未打开蓝牙后台执行.";
            break;
        case CBCentralManagerStatePoweredOff:
//            state = @"蓝牙设备关闭状态.";
            break;
        case CBCentralManagerStatePoweredOn:
//            state = @"设备已打开";
            isOk =  YES;
            break;
        case CBCentralManagerStateUnknown:
        default:
//            state = @"未知错误.";
            break;
            
    }
    
    if(!isOk){
//        NSLog(@"蓝牙不可用");
    }else{
//        NSLog(@"蓝牙设备状态%@",state);
    }
    
    
}


- (NSString *)macTrans:(NSData *)data{
    NSString *result = nil;
    if(data){
        NSString *mStr = [data description];
        mStr = [mStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        mStr = [mStr stringByReplacingOccurrencesOfString:@">" withString:@""];
        mStr = [mStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
        
        NSMutableArray *macArray = [NSMutableArray array];
        
        for(int i= 4;i<mStr.length;i +=2){
            [macArray addObject:[mStr substringWithRange:NSMakeRange(i, 2)]];
            
        }
        result = [[macArray componentsJoinedByString:@":"] uppercaseString];
    }
    
    return result ==nil?@"":result;
}


- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
//    NSLog(@"发现设备-----");
    //发现设备
    NSString *mac = [self macTrans:[advertisementData objectForKey:@"kCBAdvDataManufacturerData"]];
//    NSLog(@"Did discover peripheral %@  mac is %@", peripheral.name,mac);
    STMyPeripheral *newMyPerip = [[STMyPeripheral alloc] initWithCBPeripheral:peripheral];
    newMyPerip.advName = peripheral.name;
    newMyPerip.mac = mac;
    
    if(self.deleagte && [self.deleagte respondsToSelector:@selector(didFindNewPeripheral:)]){
        [self.deleagte didFindNewPeripheral:newMyPerip];
    }
    
}


- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)aPeripheral{
    
//    NSLog(@"蓝牙设备: %@ 已连接", aPeripheral.name);
    if(self.connectTimer){
        [self.connectTimer invalidate];//停止连接超时处理
    }
    
    NSArray *uuids = [NSArray arrayWithObjects:[CBUUID UUIDWithString:UUIDSTR_DEVICE_INFO_SERVICE], [CBUUID UUIDWithString:UUIDSTR_ISSC_PROPRIETARY_SERVICE], nil];
    
    aPeripheral.delegate = (id)self;
    [aPeripheral discoverServices:uuids];
}

/*
 Invoked whenever an existing connection with the peripheral is torn down.
 Reset local variables
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)aPeripheral error:(NSError *)error{
    
    if(self.curConnectPeripheral && self.curConnectPeripheral.peripheral == aPeripheral){
        
    }
    
}

/*
 Invoked whenever the central manager fails to create a connection with the peripheral.
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)aPeripheral error:(NSError *)error{
    
//    NSLog(@"连接蓝牙错误: %@ with error = %@", aPeripheral, [error localizedDescription]);
    
    if(self.curConnectPeripheral && self.curConnectPeripheral.peripheral == aPeripheral){
        
        if(self.deleagte && [self.deleagte respondsToSelector:@selector(connectperipher:withError:)]){
            [self.deleagte connectperipher:self.curConnectPeripheral withError:error];
        }
        
    }
    
}

#pragma mark - CBPeripheral delegate methods
/*
 Invoked upon completion of a -[discoverServices:] request.
 Discover available characteristics on interested services
 */
- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverServices:(NSError *)error{
    
    for (CBService *aService in aPeripheral.services){
//        NSLog(@"找到Service: %@", aService.UUID);
        //查找蓝牙的特征值 （读写）
        [aPeripheral discoverCharacteristics:nil forService:aService];
    }
}

- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    if ([service.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_PROPRIETARY_SERVICE]]) {
        
        for (CBCharacteristic *aChar in service.characteristics){
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_RX]]) {
                [self.curConnectPeripheral setTransparentDataWriteChar:aChar];
                
//                NSLog(@"found TRANS_RX");
                
            }else if ([aChar.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_TX]]) {
                
//                NSLog(@"found TRANS_TX");
                [self.curConnectPeripheral setTransparentDataReadChar:aChar];
            }
        }
        
        //连接成功
        if(self.curConnectPeripheral.transparentDataReadChar && self.curConnectPeripheral.transparentDataWriteChar){
            
            if(self.curConnectPeripheral && self.curConnectPeripheral.peripheral == aPeripheral){
                
                if(self.deleagte && [self.deleagte respondsToSelector:@selector(connectperipher:withError:)]){
                    [self.deleagte connectperipher:self.curConnectPeripheral withError:nil];
                }
            }
            
        }
    }
}



- (void)disconnectDevice {
    
//    NSLog(@"进入关闭蓝牙练级的方法");
    //取消超时处理
    if(self.connectTimer && [self.connectTimer isValid]){
        [self.connectTimer  invalidate];
        self.connectTimer = nil;
    }
   [self.cm cancelPeripheralConnection: self.curConnectPeripheral.peripheral];
    
}

@end
