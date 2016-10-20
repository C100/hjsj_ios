//
//  ChooseImageView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/20.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseImageView : UIView <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;
@property (nonatomic) NSMutableArray *imageButtons;
@property (nonatomic) NSMutableArray *removeButtons;
@property (nonatomic) NSMutableArray *imageViews;
@end
