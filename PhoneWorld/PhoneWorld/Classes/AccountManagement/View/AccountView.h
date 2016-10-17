//
//  AccountView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) void(^AccountCallBack)(NSInteger row);
@property (nonatomic) UITableView *accountTableView;
@end
