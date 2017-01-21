//
//  PopView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/29.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <STIDCardReader/STIDCardReader.h>
#import "BlueManager.h"

@interface PopView : UIView<UITableViewDelegate, UITableViewDataSource, BlueManagerDelegate>

@property (nonatomic) void(^PopCallBack) (id obj);

@property (nonatomic) UITableView *popTableView;

@property (nonatomic) NSMutableArray *deviceListArray;

@end
