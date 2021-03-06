//
//  TransferCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferCardView : UIScrollView <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) void(^NextCallBack) (NSDictionary *dic);

@property (nonatomic) UIButton *nextButton;

@property (nonatomic) BOOL isHJSJNumber;

@end
