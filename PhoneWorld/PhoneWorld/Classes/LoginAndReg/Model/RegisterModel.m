//
//  RegisterModel.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/31.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterModel

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.username = array[0];
        self.password = array[1];
        self.contact = array[2];
        self.codeID = array[3];
        self.tel = array[4];
        self.captcha = array[5];
        self.email = array[6];
        if ([array[7] containsString:@"代理"]) {
            self.orgType = @"0";
        }else{
            self.orgType = @"1";
        }
        self.orgName = array[8];
        self.provinceCode = array[9];
        self.cityCode = array[10];
        self.orgAddress = array[11];
        self.remdCode = array[12];
        
        
        self.photoOne = array[13];
        self.photoTwo = array[14];
        
        
        NSString *passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",self.password]];
        
        self.regDic = [@{@"userName":self.username,@"password":passwordMD5,@"contact":self.contact,@"tel":self.tel,@"remdCode":self.remdCode,@"codeId":self.codeID,@"orgType":self.orgType,@"orgName":self.orgName,@"provinceCode":self.provinceCode,@"cityCode":self.cityCode,@"orgAddress":self.orgAddress,@"captcha":self.captcha} mutableCopy];
        
        if (![array[6] isEqualToString:@"无"]) {
            [self.regDic setObject:array[6] forKey:@"email"];
        }
        
//        if (![array[10] isEqualToString:@"无"]) {
//            self.photoOne = [self.photoOne stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            [self.regDic setObject:self.photoOne forKey:@"photoOne"];
//        }
//        
//        if (![array[11] isEqualToString:@"无"]) {
//            self.photoTwo = [self.photoTwo stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            [self.regDic setObject:self.photoTwo forKey:@"photoTwo"];
//        }
    }
    return self;
}

@end
