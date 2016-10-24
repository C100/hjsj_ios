//
//  TransferCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TransferCardView.h"
#import "InputView.h"
#import "ChooseImageView.h"

@interface TransferCardView ()
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) ChooseImageView *chooseImageView;
@end

@implementation TransferCardView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"过户号码",@"姓名",@"证件号码",@"证件地址",@"联系电话"];
        self.inputViews = [NSMutableArray array];
        self.contentSize = CGSizeMake(screenWidth, 600);
        self.bounces = NO;
        for (int i = 0; i < self.leftTitles.count; i++) {
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
            [self.inputViews addObject:view];
            [self addSubview:view];
        }
        
        [self chooseImageView];
        [self nextButton];
    }
    return self;
}

- (ChooseImageView *)chooseImageView{
    if (_chooseImageView == nil) {
        _chooseImageView = [[ChooseImageView alloc] initWithFrame:CGRectZero andTitle:@"新用户（点击图片可放大）" andDetail:@[@"手持身份证正面照",@"身份证背面照"] andCount:2];
        [self addSubview:_chooseImageView];
        InputView *inputV = self.inputViews.lastObject;
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
            make.bottom.mas_equalTo(-40);
        }];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:textfont14];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method
- (void)buttonClickAction:(UIButton *)button{
    NSLog(@"---------下一步");
}
@end
