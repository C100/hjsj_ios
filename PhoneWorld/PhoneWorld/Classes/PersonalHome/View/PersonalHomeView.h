//
//  PersonalHomeView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalHomeView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) void(^PersonalHomeCallBack)(NSInteger number);
@property (nonatomic) UITableView *personalTableView;

@end
