//
//  MessageTCell.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageTCell : UITableViewCell

@property (nonatomic) MessageModel *messageModel;
@property (nonatomic) UILabel *nameLB;
@property (nonatomic) UILabel *detailLB;

@end
