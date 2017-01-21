//
//  ChannelOrderCell.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCountModel.h"

@interface ChannelOrderCell : UITableViewCell
@property (nonatomic) UILabel *nameLB;
@property (nonatomic) UILabel *phoneLB;
@property (nonatomic) UILabel *numberLB;
@property (nonatomic) UILabel *wayLB;
@property (nonatomic) OrderCountModel *orderCountModel;
@end
