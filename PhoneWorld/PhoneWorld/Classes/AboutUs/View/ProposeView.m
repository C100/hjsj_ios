//
//  ProposeView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ProposeView.h"

@implementation ProposeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        [self proposeTV];
        [self placeholderLB];
        [self submitButton];
    }
    return self;
}

- (UILabel *)placeholderLB{
    if (_placeholderLB == nil) {
        _placeholderLB = [[UILabel alloc] init];
        [self addSubview:_placeholderLB];
        [_placeholderLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(20);
        }];
        _placeholderLB.text = @"请输入您的意见与建议";
        _placeholderLB.textColor = [Utils colorRGB:@"#666666"];
        _placeholderLB.font = [UIFont systemFontOfSize:14];
        _placeholderLB.hidden = NO;
    }
    return _placeholderLB;
}

- (UITextView *)proposeTV{
    if (_proposeTV == nil) {
        _proposeTV = [[UITextView alloc] init];
        [self addSubview:_proposeTV];
        [_proposeTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(125);
        }];
        _proposeTV.delegate = self;
        _proposeTV.font = [UIFont systemFontOfSize:14];
        _proposeTV.textColor = [Utils colorRGB:@"#666666"];
        _proposeTV.layer.cornerRadius = 6;
        _proposeTV.layer.masksToBounds = YES;
    }
    return _proposeTV;
}

- (UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [[UIButton alloc] init];
        [self addSubview:_submitButton];
        [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.proposeTV.mas_bottom).mas_equalTo(20);
        }];
        _submitButton.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_submitButton setTitle:@"确认" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 6;
        _submitButton.layer.masksToBounds = YES;
        _submitButton.tag = 1120;
        [_submitButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeholderLB.hidden = YES;
}

#pragma mark - Method
- (void)buttonClickAction:(UIButton *)button{
    //提交操作  1120
}

@end
