//
//  CardTransferDetailModel.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/3.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CardTransferDetailModel : JSONModel
//过户详情model

@property (nonatomic) NSString *number;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *cardId;
@property (nonatomic) NSURL *photoOne;//new正
@property (nonatomic) NSURL *photoTwo;//old正
@property (nonatomic) NSURL *photoThree;//new反
@property (nonatomic) NSURL *photoFour;//old反
@property (nonatomic) NSString *tel;
@property (nonatomic) NSString<Optional> *address;
@property (nonatomic) NSString<Optional> *numOne;
@property (nonatomic) NSString<Optional> *numTwo;
@property (nonatomic) NSString<Optional> *numThree;

@property (nonatomic) NSString<Optional> *updateDate;
@property (nonatomic) NSString<Optional> *startName;

@end
