//
//  MessageDetailModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MessageDetailModel : JSONModel
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString<Optional> *message_description;
@property (nonatomic) NSString<Optional> *time;
@end
