//
//  OrderView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneCashCheckView.h"
#import "PhoneCashCheckTVCell.h"

@interface PhoneCashCheckView ()
@end

@implementation PhoneCashCheckView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        [self inputView];
        [self findButton];
    }
    return self;
}

- (InputView *)inputView{
    if (_inputView == nil) {
        _inputView = [[InputView alloc] init];
        _inputView.leftLabel.text = @"手机号码";
        _inputView.textField.placeholder = @"请输入手机号码";
        [self addSubview:_inputView];
        [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(screenWidth);
        }];
    }
    return _inputView;
}

- (UIView *)resultView{
    if (_resultView == nil) {
        _resultView = [[UIView alloc] init];
        [self addSubview:_resultView];
        [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.inputView.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(40);
        }];
        _resultView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        [_resultView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
        label.textColor = [Utils colorRGB:@"#999999"];
        label.font = [UIFont systemFontOfSize:textfont14];
        self.resultLabel = label;
    }
    return _resultView;
}

- (UIButton *)findButton{
    if (_findButton == nil) {
        _findButton = [Utils returnNextButtonWithTitle:@"查询"];
        [self addSubview:_findButton];
        [_findButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.inputView.mas_bottom).mas_equalTo(40);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_findButton addTarget:self action:@selector(findAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findButton;
}

#pragma mark - Method
- (void)findAction:(UIButton *)button{
    [self endEditing:YES];
    if([Utils isMobile:self.inputView.textField.text]){
        _orderCallBack(self.inputView.textField.text);
    }else{
        [Utils toastview:@"手机号格式不正确，请重新输入"];
    }
}

@end
