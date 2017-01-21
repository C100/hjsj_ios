//
//  CommisionCountView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/21.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"
#import "CountView.h"

@interface CommisionCountView : UIScrollView
@property (nonatomic) CountView *countView;//金额
@property (nonatomic) CountView *countView2;//开户量
@property (nonatomic) InputView *inputView;//总金额label
@end
