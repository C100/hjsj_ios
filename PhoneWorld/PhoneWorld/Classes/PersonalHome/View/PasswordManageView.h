//
//  PasswordManageView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordManageView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) void(^PasswordManagerCallBack)(NSInteger row);

@property (nonatomic) UITableView *passwordManageTableView;

@end
