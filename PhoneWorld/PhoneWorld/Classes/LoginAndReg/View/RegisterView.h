//
//  RegisterView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic) UITableView *registerTableView;
@property (nonatomic) NSMutableArray *inputTFs;
@property (nonatomic) UIButton *identifyingButton;

@end