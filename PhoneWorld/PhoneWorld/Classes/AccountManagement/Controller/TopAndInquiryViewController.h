//
//  TopAndInquiryViewController.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopAndInquiryView.h"

@interface TopAndInquiryViewController : UIViewController

@property (nonatomic) TopAndInquiryView *inquiryView;

+ (TopAndInquiryViewController *)sharedTopAndInquiryViewController;

//查询条件
@property (nonatomic) NSArray *inquiryConditionArray;

@end
