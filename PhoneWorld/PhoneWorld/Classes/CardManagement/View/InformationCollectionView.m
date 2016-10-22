//
//  InformationCollectionView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "InformationCollectionView.h"
#import "SettlementDetailViewController.h"
#import "ChooseImageView.h"
#import "InputView.h"

@interface InformationCollectionView ()
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSArray *detailTitles;
@property (nonatomic) ChooseImageView *chooseImageView;
@property (nonatomic) NSMutableArray *inputViews;
@end

@implementation InformationCollectionView

- (instancetype)initWithFrame:(CGRect)frame andUserinfos:(NSMutableDictionary *)userinfos
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"开户人姓名",@"证件号码",@"证件地址",@"备注"];
        self.detailTitles = @[@"请输入开户人姓名",@"请输入证件号码",@"请输入证件地址",@"请输入备注信息"];
        self.userinfosDic = userinfos;
        self.inputViews = [NSMutableArray array];
        for (int i = 0; i < self.leftTitles.count; i ++) {
            InputView *inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 41*i, screenWidth, 40)];
            [self addSubview:inputView];
            inputView.leftLabel.text = self.leftTitles[i];
            inputView.textField.placeholder = self.detailTitles[i];
            [self.inputViews addObject:inputView];
        }
        [self chooseImageView];
        [self nextButton];
    }
    return self;
}

- (ChooseImageView *)chooseImageView{
    if (_chooseImageView == nil) {
        InputView *inputV = self.inputViews.lastObject;
        _chooseImageView = [[ChooseImageView alloc] initWithFrame:CGRectZero andTitle:@"图片（点击图片可放大）"];
        [self addSubview:_chooseImageView];
        [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(inputV.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(130);
        }];
    }
    return _chooseImageView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.chooseImageView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method
- (void)buttonClickAction:(UIButton *)button{
    UIViewController *vc = [self viewController];
    SettlementDetailViewController *svc = [SettlementDetailViewController new];
    svc.userinfosDic = self.userinfosDic;
    [vc.navigationController pushViewController:svc animated:YES];
}

@end
