//
//  ChannelPartnersManageView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelPartnersManageView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UILabel *channelNumberLB;
@property (nonatomic) UILabel *orderNumberLB;
@property (nonatomic) UITableView *channelPartnersTableView;
@property (nonatomic) UITableView *orderTableView;

@end
