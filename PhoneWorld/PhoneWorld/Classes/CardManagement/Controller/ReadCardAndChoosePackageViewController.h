//
//  ReadCardAndChoosePackageViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadCardAndChoosePackageViewController : UIViewController

@property (nonatomic) NSArray *infos;

//筛选条件
@property (nonatomic) NSString *currentPoolId;//号码池ID
@property (nonatomic) NSString *currentType;//靓号规则

@end
