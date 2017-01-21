//
//  ChannelPartnersManageViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelPartnersManageView.h"

@interface ChannelPartnersManageViewController : UIViewController

+ (ChannelPartnersManageViewController *)sharedChannelPartnersManageViewController;

@property (nonatomic) NSDictionary *conditions;//订单列表查询条件

@property (nonatomic) ChannelPartnersManageView *channelView;



@end
