//
//  CardTransferListModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/3.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CardTransferListModel : JSONModel

@property (nonatomic) NSString *order_id;
@property (nonatomic) NSString *number;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *startTime;
@property (nonatomic) NSString *startName;

@property (nonatomic) NSString<Optional> *state;//过户或者补卡

@end
