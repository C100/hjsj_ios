//
//  ChoosePackageDetailView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChoosePackageDetailView.h"

#define btnWidth (screenWidth - 46)/3.0
#define btnHeight btnWidth*hw
#define hw 70/110.0

@interface ChoosePackageDetailView ()

@property (nonatomic) UIView *topView;
@property (nonatomic) NSArray *buttonTitlesArr;
@property (nonatomic) NSMutableArray *buttonsArr;

@property (nonatomic) UIView *contentView;
@property (nonatomic) NSMutableArray *labelsArr;

@property (nonatomic) UIButton *nextButton;

@end

@implementation ChoosePackageDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.buttonTitlesArr = @[@"39.9元套餐",@"59.9元套餐",@"79.9元套餐",@"199.9元套餐",@"299.9元套餐",@"399.9元套餐"];
        self.buttonsArr = [NSMutableArray array];
        self.labelsArr = [NSMutableArray array];
        [self topView];
        [self contentView];
        [self nextButton];
    }
    return self;
}

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        [self addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(60 + btnHeight*2);
        }];
        _topView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lb = [[UILabel alloc] init];
        [_topView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
        }];
        lb.text = @"选择套餐";
        lb.textColor = [Utils colorRGB:@"#666666"];
        lb.font = [UIFont systemFontOfSize:14];
        
        for (int i = 0; i < 6; i ++) {
            CGFloat line = i/3;
            CGFloat queue = i%3;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15 + (btnWidth+8)*queue, 36 + (btnHeight+8)*line, btnWidth, btnHeight)];
            [_topView addSubview:button];
            [button setTitle:self.buttonTitlesArr[i] forState:UIControlStateNormal];
            [button setTitleColor:[Utils colorRGB:@"#0081eb"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.layer.cornerRadius = 4;
            button.layer.borderColor = [Utils colorRGB:@"#0081eb"].CGColor;
            button.layer.borderWidth = 1;
            button.layer.masksToBounds = YES;
            [self.buttonsArr addObject:button];
            [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _topView;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(100);
        }];
        _contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lb = [[UILabel alloc] init];
        [_contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
        }];
        lb.text = @"套餐详情";
        lb.textColor = [Utils colorRGB:@"#666666"];
        lb.font = [UIFont systemFontOfSize:14];
        
        for (int i = 0; i < 3; i ++) {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 36+20*i, screenWidth - 30, 16)];
            lb.text = @"套餐详情";
            lb.font = [UIFont systemFontOfSize:14];
            lb.textColor = [Utils colorRGB:@"#cccccc"];
            [_contentView addSubview:lb];
            [self.labelsArr addObject:lb];
        }
    }
    return _contentView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnBextButtonWithTitle:@"确定"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method
- (void)buttonClickedAction:(UIButton *)button{
    for (UIButton *button in self.buttonsArr) {
        [button setTitleColor:[Utils colorRGB:@"#0081eb"] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
    }
    button.backgroundColor = [Utils colorRGB:@"#0081eb"];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.currentButton = button;
}

- (void)buttonClickAction:(UIButton *)button{
    //下一步
    if ([_delegate respondsToSelector:@selector(getPackage:)]) {
        [_delegate getPackage:self.currentButton.currentTitle];
    }
    UIViewController *viewController = [self viewController];
    [viewController.navigationController popViewControllerAnimated:YES];
}

@end
