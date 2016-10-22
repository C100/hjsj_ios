//
//  ChoosePackageTableView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

@interface ChoosePackageTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) InputView *inputView;

@end
