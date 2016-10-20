//
//  RepairCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepairCardView : UIScrollView <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) UIView *emailChoiceView;
@property (nonatomic) UIButton *nextButton;

@end
