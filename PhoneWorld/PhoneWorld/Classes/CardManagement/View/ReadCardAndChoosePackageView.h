//
//  ReadCardAndChoosePackageView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosePackageTableView.h"
#import "FailedView.h"

@interface ReadCardAndChoosePackageView : UIView <UITextFieldDelegate>

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSArray *)info;

@property (nonatomic) UIView *infoView;
@property (nonatomic) UIButton *nextButton;

@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSMutableArray *infos;

@property (nonatomic) ChoosePackageTableView *chooseTableView;
@property (nonatomic) FailedView *failedView;

@property (nonatomic) void(^BlueToothCallBack) (id obj);

@property (nonatomic) NSString *iccidString;//白卡开户

@property (nonatomic) UILabel *iccidStringLabel;

//@property (nonatomic) NSString *whiteCardPhoneNumber;//白卡开户手写输入暂时保存
//@property (nonatomic) NSString *whiteCardIccidString;

@end
