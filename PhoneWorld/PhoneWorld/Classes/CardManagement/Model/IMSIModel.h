//
//  IMSIModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/23.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface IMSIModel : JSONModel

@property (nonatomic) NSString *imsi;
@property (nonatomic) NSString *smscent;
@property (nonatomic) NSString *simId;
@property (nonatomic) int prestore;
@property (nonatomic) NSArray *packages;

@end
