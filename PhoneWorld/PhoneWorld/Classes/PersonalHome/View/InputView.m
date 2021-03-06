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
            make.width.mas_equalTo(100);
        }];
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.font = [UIFont systemFontOfSize:textfont16];
    }
    return _leftLabel;
}

- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        [self addSubview:_textField];
        _textField.placeholder = @"placeHolder";
        _textField.textAlignment = NSTextAlignmentRight;
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.leftLabel.mas_right).mas_equalTo(0);
        }];
        _textField.font = [UIFont systemFontOfSize:textfont16];
        [_textField setValue:[UIFont systemFontOfSize:textfont12] forKeyPath:@"_placeholderLabel.font"];
        [_textField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        _textField.textColor = [Utils colorRGB:@"#666666"];
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeyDone;
    }
    return _textField;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return YES;
}

@end
