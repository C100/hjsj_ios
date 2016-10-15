//
//  PersonalInfoView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PersonalInfoView.h"

@interface PersonalInfoView ()

@property (nonatomic) NSArray *leftTitles;

@end

@implementation PersonalInfoView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self endEditing:YES];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftTitles = @[@"用户名：",@"联系人：",@"联系号码：",@"电子邮箱：",@"渠道名称：",@"上级名称：",@"上级电话：",@"上级推荐码：",@"本人推荐码："];
        self.bounces = NO;
        self.userinfoTextFields = [NSMutableArray array];
        for (int i = 0; i < self.leftTitles.count; i++) {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + (16 + 34)*i, 90, 16)];
            [self addSubview:lb];
            lb.text = self.leftTitles[i];
            lb.font = [UIFont systemFontOfSize:14];
            lb.textColor = [Utils colorRGB:@"#333333"];
            
            UITextField  *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 10 + (30 + 20)*i, screenWidth - 110, 30)];
            [self addSubview:tf];
            tf.text = @"用户信息";
            tf.borderStyle = UITextBorderStyleRoundedRect;
            tf.textColor = [Utils colorRGB:@"#666666"];
            tf.font = [UIFont systemFontOfSize:14];
            [self.userinfoTextFields addObject:tf];
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
            make.top.mas_equalTo(460);
            make.height.mas_equalTo(40);
        }];
        _saveButton.backgroundColor = [Utils colorRGB:@"#008bd5"];
        _saveButton.layer.cornerRadius = 6;
        _saveButton.layer.masksToBounds = YES;
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTintColor:[UIColor whiteColor]];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _saveButton.tag = 1150;
        [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (void)saveAction:(UIButton *)button{
    NSLog(@"------------saveAction");
}

@end
