//
//  RepairCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepairCardView : UIScrollView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) void(^RepairCardCallBack)(NSInteger tag);

@property (nonatomic) UILabel *repairUserLB;
@property (nonatomic) UITextField *repairUserTF;

@property (nonatomic) UILabel *nameLB;
@property (nonatomic) UITextField *nameTF;

@property (nonatomic) UILabel *IDCardLB;
@property (nonatomic) UITextField *IDCardTF;

@property (nonatomic) UILabel *phoneLB;
@property (nonatomic) UITextField *phoneTF;

@property (nonatomic) UILabel *addressLB;
@property (nonatomic) UITextView *addressTV;

@property (nonatomic) UILabel *receiveUserLB;
@property (nonatomic) UITextField *receiveUserTF;

@property (nonatomic) UILabel *receivePhoneLB;
@property (nonatomic) UITextField *receivePhoneTF;

@property (nonatomic) UILabel *emailChoiceLB;
@property (nonatomic) UITextField *emailChoiceTF;
@property (nonatomic) UITableView *choiceTableView;

@property (nonatomic) UIButton *nextBtn;

@end
