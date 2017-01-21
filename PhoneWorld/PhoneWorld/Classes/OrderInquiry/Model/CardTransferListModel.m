//
//  CardTransferListModel.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/3.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardTransferListModel.h"

@implementation CardTransferListModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"order_id",@"number":@"number",@"name":@"name",@"startName":@"startName",@"startTime":@"startTime"}];
}

@end
