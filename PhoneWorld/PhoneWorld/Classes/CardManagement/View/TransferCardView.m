//
//  TransferCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TransferCardView.h"

#define imageW (screenWidth - 40)/2
#define hw 100/167.0

@interface TransferCardView ()
@property (nonatomic) NSArray *warnings;
@end

@implementation TransferCardView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.warnings = @[@"上传手持身份证正面照",@"上传手持身份证正面照",@"上传身份证背面照",@"上传身份证背面照"];
        self.contentSize = CGSizeMake(screenWidth, imageW*hw*2 + 500);
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self transferLB];
        [self transferTF];
        [self nameLB];
        [self nameTF];
        [self IDCardLB];
        [self IDCardTF];
        [self phoneLB];
        [self phoneTF];
        [self addressLB];
        [self addressTV];
        [self theNewUserLB];
        [self theOldUserLB];
        [self addIDImageButton];
        [self addIDWarningLb];
        [self nextBtn];
    }
    return self;
}

- (UILabel *)transferLB{
    if (_transferLB == nil) {
        _transferLB = [[UILabel alloc] init];
        [self addSubview:_transferLB];
        [_transferLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(75);
        }];
        _transferLB.text = @"过户号码：";
        _transferLB.textColor = [Utils colorRGB:@"#333333"];
        _transferLB.font = [UIFont systemFontOfSize:14];
    }
    return _transferLB;
}

- (UITextField *)transferTF{
    if (_transferTF == nil) {
        _transferTF = [[UITextField alloc] init];
        [self addSubview:_transferTF];
        [_transferTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(self.transferLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 95);
            make.height.mas_equalTo(30);
        }];
        _transferTF.placeholder = @"请输入号码";
        _transferTF.textColor = [Utils colorRGB:@"#333333"];
        _transferTF.font = [UIFont systemFontOfSize:14];
        _transferTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _transferTF;
}

- (UILabel *)nameLB{
    if (_nameLB == nil) {
        _nameLB = [[UILabel alloc] init];
        [self addSubview:_nameLB];
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.transferLB.mas_bottom).mas_equalTo(35);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(75);
        }];
        _nameLB.text = @"姓名：";
        _nameLB.textColor = [Utils colorRGB:@"#333333"];
        _nameLB.font = [UIFont systemFontOfSize:14];
    }
    return _nameLB;
}

- (UITextField *)nameTF{
    if (_nameTF == nil) {
        _nameTF = [[UITextField alloc] init];
        [self addSubview:_nameTF];
        [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.transferTF.mas_bottom).mas_equalTo(22);
            make.left.mas_equalTo(self.nameLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 95);
            make.height.mas_equalTo(30);
        }];
        _nameTF.placeholder = @"请输入姓名";
        _nameTF.textColor = [Utils colorRGB:@"#333333"];
        _nameTF.font = [UIFont systemFontOfSize:14];
        _nameTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _nameTF;
}

- (UILabel *)IDCardLB{
    if (_IDCardLB == nil) {
        _IDCardLB = [[UILabel alloc] init];
        [self addSubview:_IDCardLB];
        [_IDCardLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLB.mas_bottom).mas_equalTo(35);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(75);
        }];
        _IDCardLB.text = @"证件号码：";
        _IDCardLB.textColor = [Utils colorRGB:@"#333333"];
        _IDCardLB.font = [UIFont systemFontOfSize:14];
    }
    return _IDCardLB;
}

- (UITextField *)IDCardTF{
    if (_IDCardTF == nil) {
        _IDCardTF = [[UITextField alloc] init];
        [self addSubview:_IDCardTF];
        [_IDCardTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameTF.mas_bottom).mas_equalTo(22);
            make.left.mas_equalTo(self.IDCardLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 95);
            make.height.mas_equalTo(30);
        }];
        _IDCardTF.placeholder = @"请输入证件号码";
        _IDCardTF.textColor = [Utils colorRGB:@"#333333"];
        _IDCardTF.font = [UIFont systemFontOfSize:14];
        _IDCardTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _IDCardTF;
}

- (UILabel *)phoneLB{
    if (_phoneLB == nil) {
        _phoneLB = [[UILabel alloc] init];
        [self addSubview:_phoneLB];
        [_phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDCardLB.mas_bottom).mas_equalTo(35);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(75);
        }];
        _phoneLB.text = @"联系电话：";
        _phoneLB.textColor = [Utils colorRGB:@"#333333"];
        _phoneLB.font = [UIFont systemFontOfSize:14];
    }
    return _phoneLB;
}

- (UITextField *)phoneTF{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] init];
        [self addSubview:_phoneTF];
        [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.IDCardTF.mas_bottom).mas_equalTo(22);
            make.left.mas_equalTo(self.phoneLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 95);
            make.height.mas_equalTo(30);
        }];
        _phoneTF.placeholder = @"请输入联系电话";
        _phoneTF.textColor = [Utils colorRGB:@"#333333"];
        _phoneTF.font = [UIFont systemFontOfSize:14];
        _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _phoneTF;
}

- (UILabel *)addressLB{
    if (_addressLB == nil) {
        _addressLB = [[UILabel alloc] init];
        [self addSubview:_addressLB];
        [_addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneLB.mas_bottom).mas_equalTo(35);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(75);
        }];
        _addressLB.text = @"地址：";
        _addressLB.textColor = [Utils colorRGB:@"#333333"];
        _addressLB.font = [UIFont systemFontOfSize:14];
    }
    return _addressLB;
}

- (UITextView *)addressTV{
    if (_addressTV == nil) {
        _addressTV = [[UITextView alloc] init];
        _addressTV.bounces = NO;
        [self addSubview:_addressTV];
        [_addressTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_equalTo(22);
            make.left.mas_equalTo(self.addressLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 95);
            make.height.mas_equalTo(70);
        }];
        _addressTV.textColor = [Utils colorRGB:@"#333333"];
        _addressTV.font = [UIFont systemFontOfSize:14];
        _addressTV.layer.cornerRadius = 6;
        _addressTV.layer.borderColor = COLOR_BACKGROUND.CGColor;
        _addressTV.layer.borderWidth = 1;
    }
    return _addressTV;
}

- (UILabel *)theNewUserLB{
    if (_theNewUserLB == nil) {
        _theNewUserLB = [[UILabel alloc] init];
        _theNewUserLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_theNewUserLB];
        [_theNewUserLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.addressTV.mas_bottom).mas_equalTo(20);
            make.left.mas_equalTo(screenWidth/4 - 25);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(17);
        }];
        _theNewUserLB.text = @"新用户";
        _theNewUserLB.textColor = MainColor;
        _theNewUserLB.font = [UIFont systemFontOfSize:14];
    }
    return _addressLB;
}

- (UILabel *)theOldUserLB{
    if (_theOldUserLB == nil) {
        _theOldUserLB = [[UILabel alloc] init];
        _theOldUserLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_theOldUserLB];
        [_theOldUserLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.addressTV.mas_bottom).mas_equalTo(20);
            make.left.mas_equalTo(screenWidth - (screenWidth/4 - 25) - 50);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(17);
        }];
        _theOldUserLB.text = @"老用户";
        _theOldUserLB.textColor = [Utils colorRGB:@"#008bd5"];
        _theOldUserLB.font = [UIFont systemFontOfSize:14];
    }
    return _theOldUserLB;
}

- (void)addIDImageButton{
    for (int i = 0; i < 4; i ++) {
        NSInteger line = i/2;
        NSInteger queue = i%2;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10 + (imageW + 20)*line, 330 + (imageW*hw + 47)*queue, imageW, imageW*hw)];
        [self addSubview:btn];
        [btn setTitle:@"+" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:64];
        [btn setTitleColor:COLOR_BACKGROUND forState:UIControlStateNormal];
        btn.layer.cornerRadius = 6;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = COLOR_BACKGROUND.CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 800+i;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addIDWarningLb{
    for (int i = 0; i < 4; i++) {
        NSInteger line = i/2;
        NSInteger queue = i%2;
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10 + (imageW + 20)*line, 440 + (imageW*hw + 47)*queue, imageW, 15)];
        lb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lb];
        lb.text = self.warnings[i];
        lb.textColor = [Utils colorRGB:@"#999999"];
        lb.font = [UIFont systemFontOfSize:12];
    }
}

- (UIButton *)nextBtn{
    if (_nextBtn == nil) {
        _nextBtn = [[UIButton alloc] init];
        [self addSubview:_nextBtn];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(screenWidth - 20);
            make.top.mas_equalTo(self.theOldUserLB.mas_bottom).mas_equalTo(imageW*hw*2 + 110);
        }];
        _nextBtn.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 6;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.tag = 890;
        [_nextBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

#pragma mark - Method
- (void)buttonClickAction:(UIButton *)button{
    //下一步890
}
@end
