//
//  PersonalInfoDetailsModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/31.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PersonalInfoModel : JSONModel

@property (nonatomic) NSString<Optional> *username;
@property (nonatomic) NSString<Optional> *contact;
@property (nonatomic) NSString<Optional> *tel;
@property (nonatomic) NSString<Optional> *email;
@property (nonatomic) NSString<Optional> *channelName;
@property (nonatomic) NSString<Optional> *supUserName;
@property (nonatomic) NSString<Optional> *supTel;
@property (nonatomic) NSString<Optional> *supRecomdCode;
@property (nonatomic) NSString<Optional> *recomdCode;

@end
