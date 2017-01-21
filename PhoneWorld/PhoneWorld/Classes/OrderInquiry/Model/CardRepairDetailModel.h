//
//  CardTransferDetailModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/3.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CardRepairDetailModel : JSONModel

//补卡详情model
@property (nonatomic) NSString *number;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *cardId;
@property (nonatomic) NSURL *photo;
@property (nonatomic) NSString *tel;
@property (nonatomic) NSString<Optional> *address;
@property (nonatomic) NSString *receiveName;
@property (nonatomic) NSString *receiveTel;
@property (nonatomic) NSString *mailingAddress;
@property (nonatomic) NSString *mailMethod;
@property (nonatomic) NSString<Optional> *numOne;
@property (nonatomic) NSString<Optional> *numTwo;
@property (nonatomic) NSString<Optional> *numThree;
@property (nonatomic) NSString<Optional> *numFour;

@property (nonatomic) NSString<Optional> *updateDate;
@property (nonatomic) NSString<Optional> *startName;

@end
