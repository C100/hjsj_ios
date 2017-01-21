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
@property (nonatomic) NSMutableArray *buttonsArr;

@property (nonatomic) UIView *contentView;

@property (nonatomic) UIButton *nextButton;

@end

@implementation ChoosePackageDetailView

- (instancetype)initWithFrame:(CGRect)frame andPackages:(NSArray *)packages
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.packagesDic = packages;
        self.buttonsArr = [NSMutableArray array];
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
        
        int height = 0;
        if (self.packagesDic.count % 3 != 0) {
            height = (int)self.packagesDic.count/3 + 1;
        }else{
            height = (int)self.packagesDic.count/3;
        }
        
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(60 + btnHeight*height);
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
        lb.font = [UIFont systemFontOfSize:textfont14];
        
        for (int i = 0; i < self.packagesDic.count; i ++) {
            NSDictionary *dic = self.packagesDic[i];
            CGFloat line = i/3;
            CGFloat queue = i%3;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15 + (btnWidth+8)*queue, 36 + (btnHeight+8)*line, btnWidth, btnHeight)];
            [_topView addSubview:button];
            [button setTitle:dic[@"name"] forState:UIControlStateNormal];
            button.tag = 100+i;
            [button setTitleColor:[Utils colorRGB:@"#0081eb"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:textfont14];
            button.titleLabel.numberOfLines = 0;
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
        lb.font = [UIFont systemFontOfSize:textfont14];
        
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.text = @"套餐详情";
        self.detailLabel.font = [UIFont systemFontOfSize:textfont14];
        self.detailLabel.textColor = [Utils colorRGB:@"#cccccc"];
        self.detailLabel.numberOfLines = 0;
        [_contentView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(lb.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth - 30);
            make.bottom.mas_equalTo(-10);
        }];
        
    }
    return _contentView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"确定"];
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
    
    self.currentDic = self.packagesDic[button.tag - 100];
    
    
    CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont14] andMaxSize:CGSizeMake(screenWidth - 30, 0) andStr:self.currentDic[@"productDetails"]];
    
    self.detailLabel.text = self.currentDic[@"productDetails"];
    
    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.contentView.mas_bottom).mas_equalTo(36);
        make.width.mas_equalTo(screenWidth - 30);
        make.height.mas_equalTo(size.height + 10);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(screenWidth);
        make.height.mas_equalTo(size.height + 10 + 46);
        make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(10);
    }];
    
    [self.nextButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_bottom).mas_equalTo(40);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(171);
    }];
    
}

- (void)buttonClickAction:(UIButton *)button{
    //下一步
    if ([_delegate respondsToSelector:@selector(getPackage:)]) {
        [_delegate getPackage:self.currentDic];
    }
    UIViewController *viewController = [self viewController];
    [viewController.navigationController popViewControllerAnimated:YES];
}

@end
