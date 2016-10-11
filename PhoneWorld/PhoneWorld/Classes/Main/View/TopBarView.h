//
//  TopBarView.h
//  hjtx
//
//  Created by 朱林峰 on 2016/10/7.
//  Copyright © 2016年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBarView : UIView
@property UILabel *titlel;
@property UIView *topview;
@property UIButton *backbutton;
@property UIButton *rightButton;

-(UIView*)createTopBar:(NSString *)title;
-(void)addBackButton;
-(void)addRightButton:(UIImage*)image;
-(void)addRightButtonWithText:(NSString *)text;
@end
