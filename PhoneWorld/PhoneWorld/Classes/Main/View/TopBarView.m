//
//  TopBarView.m
//  hjtx
//
//  Created by 朱林峰 on 2016/10/7.
//  Copyright © 2016年 james. All rights reserved.
//

#import "TopBarView.h"

@implementation TopBarView
@synthesize titlel,topview,backbutton;

-(UIView*)createTopBar:(NSString *)title
{
    CGSize screensize=[UIScreen mainScreen].bounds.size;
    topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0,screensize.width , 64)];
    topview.backgroundColor=MainColor;
    titlel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, screensize.width, 64-20)];
    titlel.text=title;
    titlel.textColor=[UIColor whiteColor];
    titlel.textAlignment=NSTextAlignmentCenter;
    titlel.font=[UIFont systemFontOfSize:18];
    [topview addSubview:titlel];
    
    UILabel *heng=[[UILabel alloc] init];
    heng.backgroundColor=COLOR_BACKGROUND;
    heng.frame=CGRectMake(0, 63, screenWidth, 1);
    [topview addSubview:heng];
    return topview;
}

//-(void)addBackButton{
//    UIButton *backb=[[UIButton alloc]initWithFrame:CGRectMake(10, 34, 10, 16)];
//    backb.adjustsImageWhenHighlighted=NO;
//    [backb setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//    [topview addSubview:backb];
//    backbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 44)];
//    backbutton.adjustsImageWhenHighlighted=NO;
//    //[backbutton setBackgroundImage:[UIImage imageNamed: @"left.png"] forState:UIControlStateNormal];
//    [topview addSubview:backbutton];
//}
//
//-(void)addRightButton:(UIImage*)image
//{
//    UIButton *right=[[UIButton alloc] initWithFrame:CGRectMake(screenWidth-30, 34, 20, 20)];
//    right.adjustsImageWhenHighlighted=NO;
//    [right setImage:image forState:UIControlStateNormal];
//    [topview addSubview:right];
//    _rightButton=[[UIButton alloc] initWithFrame:CGRectMake(screenWidth-30, 20, 50, 44)];
//    _rightButton.adjustsImageWhenHighlighted=NO;
//    [topview addSubview:_rightButton];
//}

-(void)addRightButtonWithText:(NSString *)text
{
    UIButton *right=[[UIButton alloc] initWithFrame:CGRectMake(screenWidth-60, 20, 50, 44)];
    right.adjustsImageWhenHighlighted=NO;
    [right setTitle:text forState:UIControlStateNormal];
    [right setTitleColor:COLOR_DARK_GREY forState:UIControlStateNormal];
    right.titleLabel.font=[UIFont systemFontOfSize:15*PX_WIDTH];
    right.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [topview addSubview:right];
    _rightButton=[[UIButton alloc] initWithFrame:CGRectMake(screenWidth-60, 20, 50, 44)];
    _rightButton.adjustsImageWhenHighlighted=NO;
    [topview addSubview:_rightButton];
}

@end
