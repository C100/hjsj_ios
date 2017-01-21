//
//  WhitePhoneModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WhitePhoneModel : JSONModel

//手机号信息白卡开户得到
@property (nonatomic) NSString *num;
@property (nonatomic) NSString *ltype;//类型
@property (nonatomic) NSString *infos;//说明
@property (nonatomic) NSString<Optional> *rules;//靓号规则
@property (nonatomic) NSString<Optional> *pool;//号码池

@end
