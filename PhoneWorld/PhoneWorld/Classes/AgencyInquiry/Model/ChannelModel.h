//
//  ChannelModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/23.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ChannelModel : JSONModel

@property (nonatomic) NSString *contact;
@property (nonatomic) NSString *orgCode;
@property (nonatomic) NSString *name;

@end
