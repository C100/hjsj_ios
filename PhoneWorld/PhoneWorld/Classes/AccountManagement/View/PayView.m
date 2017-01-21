//
//  PayView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PayView.h"

#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height (screenWidth - 32)/6  //每一个输入框的高度

@interface PayView ()

@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点

@end

@implementation PayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [Utils colorRGB:@"#ffffff"];
        [self closeButton];
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        lb.text = @"输入密码";
        lb.font = [UIFont systemFontOfSize:textfont18];
        UIView *lineV = [[UIView alloc] init];
        [self addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lb.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        lineV.backgroundColor = [Utils colorRGB:@"#eaeaea"];
        
        [self addSubview:self.textField];

        [self initPwdTextField];
    }
    return self;
}

- (UIButton *)closeButton{
    if (_closeButton == nil) {
        _closeButton = [[UIButton alloc] init];
        [self addSubview:_closeButton];
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.height.mas_equalTo(40);
        }];
        [_closeButton setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(16, 70, screenWidth - 32, K_Field_Height)];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[Utils colorRGB:@"#eaeaea"] CGColor];
        _textField.layer.borderWidth = 1;
        _textField.layer.cornerRadius = 6;
        _textField.layer.masksToBounds = YES;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat width = (screenWidth - 32) / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, CGRectGetMinY(self.textField.frame), 1, K_Field_Height)];
        lineView.backgroundColor = [Utils colorRGB:@"#eaeaea"];
        [self addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - kDotCount) / 2 + i * width, CGRectGetMinY(self.textField.frame) + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
//        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        _PayCallBack(textField.text);
    }
}

#pragma mark - Method 

- (void)closeAction:(UIButton *)button{
    _ClosePayCallBack(button);
}

@end
