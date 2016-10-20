//
//  InputView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "InputView.h"

@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self leftLabel];
        [self rightLabel];
        [self textField];
    }
    return self;
}

- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        [self addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        _leftLabel.textColor = [Utils colorRGB:@"#666666"];
        _leftLabel.font = [UIFont systemFontOfSize:14];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        [self addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        }];
        _rightLabel.textColor = [Utils colorRGB:@"#cccccc"];
        _rightLabel.font = [UIFont systemFontOfSize:12];
    }
    return _rightLabel;
}

- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        [self addSubview:_textField];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(screenWidth - 30 - 100);
        }];
        _textField.font = [UIFont systemFontOfSize:12];
        _textField.textColor = [Utils colorRGB:@"#666666"];
        _textField.hidden = YES;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeyDone;
        [_textField addTarget:self action:@selector(textFieldStateChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    self.textField.hidden = YES;
    return YES;
}

#pragma mark - Method

- (void)textFieldStateChanged:(UITextField *)textField{
    self.rightLabel.text = textField.text;
    self.rightLabel.textColor = [Utils colorRGB:@"#666666"];
}

@end
