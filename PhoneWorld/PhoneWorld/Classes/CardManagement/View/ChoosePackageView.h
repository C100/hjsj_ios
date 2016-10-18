//
//  ChoosePackageView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePackageView : UIView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
- (instancetype)initWithFrame:(CGRect)frame andUserinfos:(NSArray *)userinfos;
@property (nonatomic) NSArray *userinfos;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIButton *nextButton;
@property (nonatomic) UITextField *moneyTF;
@end
