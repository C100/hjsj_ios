//
//  OrderView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneCashCheckView : UIView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic) void(^orderCallBack)(NSInteger tag);

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIButton *findButton;
@property (nonatomic) NSString *phoneNum;
@property (nonatomic) UITextField *inputTextField;

@property (nonatomic) NSArray *userinfos;
@property (nonatomic) UITableView *resultTableView;

@end
