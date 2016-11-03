//
//  MessageDetailModel.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MessageDetailModel.h"

@implementation MessageDetailModel
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"title":@"title",@"content":@"content",@"description":@"message_description",@"time":@"time"}];
}
@end
