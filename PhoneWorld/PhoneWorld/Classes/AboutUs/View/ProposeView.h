//
//  ProposeView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProposeView : UIView<UITextViewDelegate>

@property (nonatomic) void(^ProposeCallBack)(NSString *propose);
@property (nonatomic) UILabel *placeholderLB;
@property (nonatomic) UITextView *proposeTV;
@property (nonatomic) UIButton *submitButton;

@end
