//
//  ProvinceModel.h
//  UIPickerView选择地址
//
//  Created by 刘岑颖 on 16/12/6.
//  Copyright © 2016年 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@interface ProvinceModel : NSObject

@property (nonatomic) NSString *provinceId;
@property (nonatomic) NSString *provinceName;
@property (nonatomic) NSMutableArray<CityModel *> *cityArray;

@end
