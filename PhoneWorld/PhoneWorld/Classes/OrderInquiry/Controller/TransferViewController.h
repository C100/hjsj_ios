//
//  TransferViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderView.h"

@interface TransferViewController : UIViewController
+ (TransferViewController *)sharedTransferViewController;
@property (nonatomic) OrderView *orderView;
@end
