//
//  PersonCardModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/30.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PersonCardModel : JSONModel

//读身份证读出来的信息

@property (nonatomic) NSString *Address;
@property (nonatomic) NSString *Born;
@property (nonatomic) NSString *CardNo;
@property (nonatomic) NSString *EffectedDate;
@property (nonatomic) NSString *ExpiredDate;
@property (nonatomic) NSString *IssuedAt;
@property (nonatomic) NSString *Name;
@property (nonatomic) NSString *Nation;
@property (nonatomic) NSString *Sex;

@end
