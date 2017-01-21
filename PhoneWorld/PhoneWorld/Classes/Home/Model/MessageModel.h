//
//  MessageModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MessageModel : JSONModel

@property (nonatomic) NSString *message_id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *updateDate;

@end
