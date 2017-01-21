//
//  RepairCardDetailView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardRepairDetailModel.h"
#import "CardTransferListModel.h"

@interface RepairCardDetailView : UIScrollView

@property (nonatomic) CardRepairDetailModel *detailModel;

@property (nonatomic) CardTransferListModel *listModel;

@end
