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
        self.tel = array[4];
        self.email = array[6];
        self.remdCode = array[9];
        self.codeID = array[3];
        if ([array[7] containsString:@"代理"]) {
            self.orgType = @"0";
        }else{
            self.orgType = @"1";
        }
        self.orgName = array[8];
        self.photoOne = array[10];
        self.photoTwo = array[11];
        
        self.photoOne = [self.photoOne stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        self.photoTwo = [self.photoTwo stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        NSString *passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",self.password]];
        self.regDic = [@{@"userName":self.username,@"password":passwordMD5,@"contact":self.contact,@"tel":self.tel,@"email":self.email,@"remdCode":self.remdCode,@"codeId":self.codeID,@"orgType":self.orgType,@"orgName":self.orgName,@"photoOne":self.photoOne,@"photoTwo":self.photoTwo} mutableCopy];
    }
    return self;
}

@end
