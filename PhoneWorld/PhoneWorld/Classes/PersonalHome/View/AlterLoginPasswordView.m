//
//  AlterLoginPasswordView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AlterLoginPasswordView.h"

@interface AlterLoginPasswordView ()

@property (nonatomic) NSArray *leftTitles;

@end

@implementation AlterLoginPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftTitles = @[@"原密码：",@"新密码：",@"确认密码："];
        self.backgroundColor = [UIColor whiteColor];
        self.passwordTextFields = [NSMutableArray array];
        for (int i = 0; i < self.leftTitles.count; i ++) {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + (16 + 34)*i, 90, 16)];
            [self addSubview:lb];
            lb.text = self.leftTitles[i];
            lb.font = [UIFont systemFontOfSize:14];
            lb.textColor = [Utils colorRGB:@"#333333"];
            
            UITextField  *tf = [[UITextField alloc] initWithFrame:CGRectMake(90, 10 + (30 + 20)*i, screenWidth - 100, 30)];
            [self addSubview:tf];
            tf.secureTextEntry = YES;
            tf.borderStyle = UITextBorderStyleRoundedRect;
            tf.textColor = [Utils colorRGB:@"#666666"];
            tf.font = [UIFont systemFontOfSize:14];
            [self.passwordTextFields addObject:tf];
        }
        [self saveButton];
    }
    return self;
}

- (UIButton *)saveButton{
    if (_saveButton == nil) {
        _saveButton = [[UIButton alloc] init];
        [self addSubview:_saveButton];
        [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(screenWidth - 20);
            make.top.mas_equalTo(160);
            make.height.mas_equalTo(40);
        }];
        _saveButton.backgroundColor = [Utils colorRGB:@"#008bd5"];
        _saveButton.layer.cornerRadius = 6;
        _saveButton.layer.masksToBounds = YES;
        [_saveButton setTitle:@"确定" forState:UIControlStateNormal];
        [_saveButton setTintColor:[UIColor whiteColor]];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _saveButton.tag = 1160;
        [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (void)saveAction:(UIButton *)button{
    _AlterPasswordCallBack(button.tag);
}

@end
