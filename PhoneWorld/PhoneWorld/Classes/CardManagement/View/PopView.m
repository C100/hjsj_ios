//
//  PopView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/29.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PopView.h"

//#define ERROR
#define UDValue(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define SETUDValue(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]

#define SERVER @"SERVERIP"  //@"192.168.1.10"//@"222.134.70.138" //
#define PORT @"SERVERPORT" //10002//8088 //

@implementation PopView{
    STIDCardReader *scaleManager;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.deviceListArray = [NSMutableArray array];
        
        UIView *backView = [[UIView alloc] init];
        [self addSubview:backView];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.4;
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [backView addGestureRecognizer:tap];
        
        if(UDValue(SERVER)== nil){
            SETUDValue(@"senter-online.cn", SERVER);
        }
        
        if(UDValue(PORT) == nil){
            SETUDValue(@"10002", PORT);
        }
        scaleManager = [STIDCardReader instance];
        scaleManager.delegate = (id)self;
        [scaleManager setServerIp:UDValue(SERVER) andPort:[UDValue(PORT) intValue]];
        
        [self popTableView];
        
        BlueManager *manager = [BlueManager instance];
        manager.deleagte = self;
        [manager startScan];
    }
    return self;
}

- (UITableView *)popTableView{
    if (_popTableView == nil) {
        _popTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self addSubview:_popTableView];
        [_popTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(400);
        }];
        _popTableView.delegate = self;
        _popTableView.dataSource = self;
        _popTableView.tableFooterView = [UIView new];
        [_popTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _popTableView;
}

#pragma mark - Method
- (void)tapAction:(UITapGestureRecognizer *)tap{
    _PopCallBack(tap);
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.deviceListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    STMyPeripheral *peripheral = [self.deviceListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = peripheral.advName;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"发现设备列表:";
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if([self.deviceListArray count] >indexPath.row){
        STMyPeripheral *peripheral = [self.deviceListArray objectAtIndex: indexPath.row];
        [[BlueManager instance] stopScan];
        //先建立连接，连接上以后 传给SDK
        [[BlueManager instance] connectPeripher:peripheral];
    }
    
}

#pragma mark BlueManagerDelegate
//蓝牙扫描回调
- (void)didFindNewPeripheral:(STMyPeripheral *)periperal{
    if(_deviceListArray == nil){
        _deviceListArray = [[NSMutableArray alloc] init];
    }
    if(_deviceListArray != nil){
        if([_deviceListArray count] == 0){
            [_deviceListArray addObject:periperal];
            [self.popTableView reloadData];
        }else{
            BOOL isexit = NO;
            for (uint8_t i = 0; i < [_deviceListArray count]; i++) {
                STMyPeripheral *myPeripherali = [_deviceListArray objectAtIndex:i];
                if(myPeripherali != nil){
                    if([periperal.advName isEqualToString:myPeripherali.advName] && [periperal.mac isEqualToString:myPeripherali.mac]){
                        isexit = YES;
                        break;
                    }
                }
            }
            if(!isexit){
                [_deviceListArray addObject:periperal];
                [self.popTableView reloadData];
            }
        }
    }
    //    if(![deviceList containsObject:periperal]){
    //        [deviceList addObject:periperal];
    //        [self.table reloadData];
    //    }
}

//连接设备的回调，成功 error为nil
- (void)connectperipher:(STMyPeripheral *)peripheral withError:(NSError *)error{
    if(error){
        NSString *errMsg = [NSString stringWithFormat:@"错误代码:%ld,错误信息:%@!", (long)[error code], [error localizedDescription]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }else{
        [scaleManager setLisentPeripheral:peripheral];          //设置SDK的监听蓝牙设备
        
        NSString *msg = [NSString stringWithFormat:@"已连接上 %@",peripheral.advName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
        _PopCallBack(nil);
        
        //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //   [self leftNavBarClick:nil];
        //});
        
    }
}

@end
