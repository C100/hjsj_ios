//
//  AddressPickerView.h
//  地址选择PickerView话机世界
//
//  Created by 刘岑颖 on 16/12/7.
//  Copyright © 2016年 lcy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinceModel.h"
#import "CityModel.h"

@interface AddressPickerView : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) ProvinceModel *currentProvinceModel;
@property (nonatomic) CityModel *currentCityModel;

@end
