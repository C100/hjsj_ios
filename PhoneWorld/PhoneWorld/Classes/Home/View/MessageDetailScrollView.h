//
//  MessageDetailScrollView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDetailModel.h"

@interface MessageDetailScrollView : UIScrollView

@property (nonatomic) UILabel *detailLabel;
@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) MessageDetailModel *detailModel;

@end
