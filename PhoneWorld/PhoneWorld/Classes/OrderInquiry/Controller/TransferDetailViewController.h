//
//  TransferDetailViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardTransferListModel.h"

@interface TransferDetailViewController : UIViewController

@property (nonatomic) CardTransferListModel *listModel;

@property (nonatomic) NSString *modelId;

@end
