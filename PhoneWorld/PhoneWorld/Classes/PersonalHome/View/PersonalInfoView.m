//
//  PersonalInfoView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PersonalInfoView.h"
#import "InputView.h"

@interface PersonalInfoView ()
@property (nonatomic) NSMutableArray *leftTitles;
@end

@implementation PersonalInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        
        self.leftTitles = [@[@"用户名",@"姓名",@"手机号码",@"电子邮箱",@"渠道名称",@"上级名称",@"上级电话"] mutableCopy];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *grade = [ud objectForKey:@"grade"];
                
        if ([grade isEqualToString:@"lev3"]) {
            [self.leftTitles addObject:@"上级推荐码"];
        }
        if ([grade isEqualToString:@"lev2"]) {
            [self.leftTitles addObjectsFromArray:@[@"本人推荐码",@"上级推荐码"]];
        }
        if ([grade isEqualToString:@"lev1"]) {
            [self.leftTitles addObject:@"本人推荐码"];
        }
        
        self.inputViews = [NSMutableArray array];
        self.bounces = NO;
        for (int i = 0; i < self.leftTitles.count; i ++) {
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.placeholder = self.leftTitles[i];
            view.tag = 100+i;
            [self.inputViews addObject:view];
            view.textField.userInteractionEnabled = NO;
        }
        
        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40*self.leftTitles.count)];
        leftV.backgroundColor = [UIColor whiteColor];
        [self addSubview:leftV];
    }
    return self;
}

- (void)setPersonModel:(PersonalInfoModel *)personModel{
    for (InputView *inputV in self.inputViews) {
        
        //@"用户名",@"姓名",@"手机号码",@"电子邮箱",@"渠道名称",@"上级名称",@"上级电话",@"上级推荐码",@"本人推荐码"
        
        if ([inputV.leftLabel.text isEqualToString:@"用户名"]) {
            inputV.textField.text = personModel.username;
        }
        if ([inputV.leftLabel.text isEqualToString:@"姓名"]) {
            inputV.textField.text = personModel.contact;
        }
        if ([inputV.leftLabel.text isEqualToString:@"手机号码"]) {
            inputV.textField.text = personModel.tel;
        }
        if ([inputV.leftLabel.text isEqualToString:@"电子邮箱"]) {
            inputV.textField.text = personModel.email;
            
            if ([personModel.email isEqualToString:@""]) {
                inputV.textField.text = @"未填写";
            }
        }
        if ([inputV.leftLabel.text isEqualToString:@"渠道名称"]) {
            inputV.textField.text = personModel.channelName;
        }
        if ([inputV.leftLabel.text isEqualToString:@"上级名称"]) {
            inputV.textField.text = personModel.supUserName;
        }
        if ([inputV.leftLabel.text isEqualToString:@"上级电话"]) {
            inputV.textField.text = personModel.supTel;
        }
        if ([inputV.leftLabel.text isEqualToString:@"上级推荐码"]) {
            if (personModel.supRecomdCode) {
                inputV.textField.text = personModel.supRecomdCode;
            }else{
                inputV.textField.text = @"无";
            }
        }
        if ([inputV.leftLabel.text isEqualToString:@"本人推荐码"]) {
            inputV.textField.text = personModel.recomdCode;
        }
        
    }
}


@end
