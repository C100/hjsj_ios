//
//  ChannelPartnersManageView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelModel.h"
#import "OrderCountModel.h"

@interface ChannelPartnersManageView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UILabel *channelNumberLB;
@property (nonatomic) UILabel *orderNumberLB;
@property (nonatomic) UITableView *channelPartnersTableView;
@property (nonatomic) UITableView *orderTableView;

@property (nonatomic) NSMutableArray<ChannelModel *> *channelArray;
@property (nonatomic) NSMutableArray<OrderCountModel *> *orderArray;

@end
