//
//  TransferDetailView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardTransferDetailModel.h"
#import "CardTransferListModel.h"

@interface TransferDetailView : UIScrollView

@property (nonatomic) CardTransferListModel *listModel;
@property (nonatomic) CardTransferDetailModel *detailModel;

@end
