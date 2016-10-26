//
//  ScreenView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreenView : UIView <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

/*
 contentDic中保存标题和标题下的选项
 如果是选择时间  选项内容为@"timePicker"
 如果是手机号  选项内容为@"phoneNumber"
 */

@property (nonatomic) void(^ScreenCallBack) (NSString *buttonTitle);
- (instancetype)initWithFrame:(CGRect)frame andContent:(NSDictionary *)content andLeftTitles:(NSArray *)titles andRightDetails:(NSArray *)details;

@end
