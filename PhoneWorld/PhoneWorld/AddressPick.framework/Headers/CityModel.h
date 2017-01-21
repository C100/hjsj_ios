//
//  CityModel.h
//  UIPickerView选择地址
//
//  Created by 刘岑颖 on 16/12/6.
//  Copyright © 2016年 lcy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (nonatomic) NSString *cityId;
@property (nonatomic) NSString *cityName;
@property (nonatomic) NSMutableArray *countyArray;

@end
