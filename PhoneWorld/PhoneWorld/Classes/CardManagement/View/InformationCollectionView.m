//
//  InformationCollectionView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "InformationCollectionView.h"
#import "SettlementDetailViewController.h"

@interface InformationCollectionView ()
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSArray *detailTitles;

@property (nonatomic) BOOL isFinished;

@end

@implementation InformationCollectionView

- (instancetype)initWithFrame:(CGRect)frame andIsFinished:(BOOL)isFinished
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        
        self.inputViews = [NSMutableArray array];
                
        self.detailTitles = @[@"请输入开户人姓名",@"请输入证件号码",@"请输入证件地址",@"请输入备注信息"];
        self.isFinished = isFinished;
        if (isFinished == YES) {
            self.leftTitles = @[@"开户人姓名",@"证件号码",@"证件地址",@"备注"];
        }else{
            self.leftTitles = @[@"开户人姓名",@"证件号码",@"证件地址"];
        }
        
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
        _chooseImageView = [[ChooseImageView alloc] initWithFrame:CGRectZero andTitle:@"图片（点击图片可放大）" andDetail:@[@"手持身份证正面照",@"身份证背面照"] andCount:2];
        [self addSubview:_chooseImageView];
        [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(inputV.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(185);
        }];
    }
    return _chooseImageView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"下一步"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.chooseImageView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method
- (void)buttonClickAction:(UIButton *)button{
    
    for (int i = 0; i < self.leftTitles.count; i ++) {
        InputView *inputV = self.inputViews[i];
        if (i != self.leftTitles.count - 1) {
            if ([inputV.textField.text isEqualToString:@""]) {
                [Utils toastview:@"请输入完整"];
                return;
            }
        }
    }
    
    for (int i = 0; i < 2; i++) {
        UIImageView *imageV = self.chooseImageView.imageViews[i];
        if (imageV.hidden == YES || !imageV.image) {
            [Utils toastview:@"请选择图片"];
            return;
        }
    }
    
    //@"开户人姓名",@"证件号码",@"证件地址",@"备注"
    NSMutableDictionary *infosDictionary = [NSMutableDictionary dictionary];
    NSArray *keysArray = @[@"customerName",@"certificatesNo",@"address",@"description"];//备注不一定有
    for (int i = 0; i < self.leftTitles.count; i ++) {
        InputView *inputV = self.inputViews[i];
        
        if (![inputV.textField.text isEqualToString:@""]) {
            [infosDictionary setObject:inputV.textField.text forKey:keysArray[i]];
        }
        
    }
    
    NSArray *photoKeysArray = @[@"photoFront",@"photoBack"];
    for (int i = 0; i < 2; i++) {
        UIImageView *imageV = self.chooseImageView.imageViews[i];
        [infosDictionary setObject:[Utils imagechange:imageV.image] forKey:photoKeysArray[i]];
    }
    
    [infosDictionary setObject:@"Idcode" forKey:@"certificatesType"];
    
    if (_isFinished == YES) {
        [infosDictionary setObject:@"SIM" forKey:@"cardType"];
    }else{
        [infosDictionary setObject:@"ESIM" forKey:@"cardType"];
    }
    _nextCallBack(infosDictionary);
}

@end
