//
//  RegisterModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/31.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject

@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *contact;
@property (nonatomic) NSString *tel;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *remdCode;
@property (nonatomic) NSString *codeID;//身份证
@property (nonatomic) NSString *orgType;
@property (nonatomic) NSString *orgName;
@property (nonatomic) NSString *photoOne;//营业执照照片
@property (nonatomic) NSString *photoTwo;//本人照片

@property (nonatomic) NSString *captcha;//验证码

@property (nonatomic) NSString *provinceCode;//省份编码
@property (nonatomic) NSString *cityCode;//城市编码
@property (nonatomic) NSString *orgAddress;//渠道地址

@property (nonatomic) NSMutableDictionary *regDic;

- (instancetype)initWithArray:(NSArray *)array;

@end
