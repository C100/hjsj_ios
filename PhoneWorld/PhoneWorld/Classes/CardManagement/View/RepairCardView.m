//
//  RepairCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RepairCardView.h"

#define imageW (screenWidth-40)/2
#define hw 100/167.0

@interface RepairCardView ()
@property (nonatomic) NSArray *choices;
@property (nonatomic) NSArray *warnings;
@end

@implementation RepairCardView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(screenWidth, 650);
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];

        self.choices = @[@"顺丰到付",@"充值一百免邮费"];
        self.warnings = @[@"上传手持身份证正面照", @"上传身份证背面照"];
        
        [self repairUserLB];
        [self repairUserTF];
        [self nameLB];
        [self nameTF];
        [self IDCardLB];
        [self IDCardTF];
        [self phoneLB];
        [self phoneTF];
        [self addressLB];
        [self addressTV];
        
        [self receiveUserLB];
        [self receiveUserTF];
        [self receivePhoneLB];
        [self receivePhoneTF];
        [self emailChoiceLB];
        [self emailChoiceTF];
        [self addIDImageButton];
        [self addIDWarningLb];
        [self nextBtn];
        [self choiceTableView];
    }
    return self;
}

- (UILabel *)repairUserLB{
    if (_repairUserLB == nil) {
        _repairUserLB = [[UILabel alloc] init];
        [self addSubview:_repairUserLB];
        [_repairUserLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(90);
        }];
        _repairUserLB.text = @"补卡号码：";
        _repairUserLB.textColor = [Utils colorRGB:@"#333333"];
        _repairUserLB.font = [UIFont systemFontOfSize:14];
    }
    return _repairUserLB;
}

- (UITextField *)repairUserTF{
    if (_repairUserTF == nil) {
        _repairUserTF = [[UITextField alloc] init];
        [self addSubview:_repairUserTF];
        [_repairUserTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(self.repairUserLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 110);
            make.height.mas_equalTo(30);
        }];
        _repairUserTF.placeholder = @"请输入号码";
        _repairUserTF.textColor = [Utils colorRGB:@"#333333"];
        _repairUserTF.font = [UIFont systemFontOfSize:14];
        _repairUserTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _repairUserTF;
}

- (UILabel *)nameLB{
    if (_nameLB == nil) {
        _nameLB = [[UILabel alloc] init];
        [self addSubview:_nameLB];
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.repairUserLB.mas_bottom).mas_equalTo(35);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(90);
        }];
        _nameLB.text = @"补卡人姓名：";
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
            make.top.mas_equalTo(self.repairUserTF.mas_bottom).mas_equalTo(22);
            make.left.mas_equalTo(self.nameLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 110);
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
            make.width.mas_equalTo(90);
        }];
        _IDCardLB.text = @"身份证号码：";
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
            make.width.mas_equalTo(screenWidth - 110);
            make.height.mas_equalTo(30);
        }];
        _IDCardTF.placeholder = @"请输入身份证号码";
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
            make.width.mas_equalTo(90);
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
            make.width.mas_equalTo(screenWidth - 110);
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
            make.width.mas_equalTo(90);
        }];
        _addressLB.text = @"邮寄地址：";
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
            make.width.mas_equalTo(screenWidth - 110);
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

- (UILabel *)receiveUserLB{
    if (_receiveUserLB == nil) {
        _receiveUserLB = [[UILabel alloc] init];
        [self addSubview:_receiveUserLB];
        [_receiveUserLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.addressLB.mas_bottom).mas_equalTo(75);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(90);
        }];
        _receiveUserLB.text = @"收件人姓名：";
        _receiveUserLB.textColor = [Utils colorRGB:@"#333333"];
        _receiveUserLB.font = [UIFont systemFontOfSize:14];
    }
    return _receiveUserLB;
}

- (UITextField *)receiveUserTF{
    if (_receiveUserTF == nil) {
        _receiveUserTF = [[UITextField alloc] init];
        [self addSubview:_receiveUserTF];
        [_receiveUserTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.addressTV.mas_bottom).mas_equalTo(22);
            make.left.mas_equalTo(self.receiveUserLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 110);
            make.height.mas_equalTo(30);
        }];
        _receiveUserTF.placeholder = @"请输入收件人姓名：";
        _receiveUserTF.textColor = [Utils colorRGB:@"#333333"];
        _receiveUserTF.font = [UIFont systemFontOfSize:14];
        _receiveUserTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _receiveUserTF;
}

- (UILabel *)receivePhoneLB{
    if (_receivePhoneLB == nil) {
        _receivePhoneLB = [[UILabel alloc] init];
        [self addSubview:_receivePhoneLB];
        [_receivePhoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.receiveUserLB.mas_bottom).mas_equalTo(35);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(90);
        }];
        _receivePhoneLB.text = @"收件人电话：";
        _receivePhoneLB.textColor = [Utils colorRGB:@"#333333"];
        _receivePhoneLB.font = [UIFont systemFontOfSize:14];
    }
    return _receivePhoneLB;
}

- (UITextField *)receivePhoneTF{
    if (_receivePhoneTF == nil) {
        _receivePhoneTF = [[UITextField alloc] init];
        [self addSubview:_receivePhoneTF];
        [_receivePhoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.receiveUserTF.mas_bottom).mas_equalTo(22);
            make.left.mas_equalTo(self.receivePhoneLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 110);
            make.height.mas_equalTo(30);
        }];
        _receivePhoneTF.placeholder = @"请输入收件人联系电话";
        _receivePhoneTF.textColor = [Utils colorRGB:@"#333333"];
        _receivePhoneTF.font = [UIFont systemFontOfSize:14];
        _receivePhoneTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _receivePhoneTF;
}

- (UILabel *)emailChoiceLB{
    if (_emailChoiceLB == nil) {
        _emailChoiceLB = [[UILabel alloc] init];
        [self addSubview:_emailChoiceLB];
        [_emailChoiceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.receivePhoneLB.mas_bottom).mas_equalTo(35);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(90);
        }];
        _emailChoiceLB.text = @"邮寄选项：";
        _emailChoiceLB.textColor = [Utils colorRGB:@"#333333"];
        _emailChoiceLB.font = [UIFont systemFontOfSize:14];
    }
    return _emailChoiceLB;
}

- (UITextField *)emailChoiceTF{
    if (_emailChoiceTF == nil) {
        _emailChoiceTF = [[UITextField alloc] init];
        _emailChoiceTF.borderStyle = UITextBorderStyleRoundedRect;
        
        [_emailChoiceTF setFont:[UIFont systemFontOfSize:14]];
        [_emailChoiceTF setTextColor:[Utils colorRGB:@"#333333"]];
        _emailChoiceTF.enabled = NO;
        
        [self addSubview:_emailChoiceTF];
        [_emailChoiceTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.receivePhoneTF.mas_bottom).mas_equalTo(20);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.emailChoiceLB.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(screenWidth - 110);
        }];
        
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_emailChoiceTF.mas_right).mas_equalTo(-6);
            make.top.mas_equalTo(_emailChoiceTF.mas_top).mas_equalTo(12);
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(6);
        }];
        [btn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        btn.tag = 950;
        [btn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emailChoiceTF;
}

- (UITableView *)choiceTableView{
    if (_choiceTableView == nil) {
        _choiceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        [self addSubview:_choiceTableView];
        [_choiceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.emailChoiceTF.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(self.phoneLB.mas_right).mas_equalTo(0);
            make.height.mas_equalTo(2*28);
            make.width.mas_equalTo(screenWidth - 110);
        }];
        _choiceTableView.backgroundColor = [UIColor whiteColor];
        _choiceTableView.delegate = self;
        _choiceTableView.dataSource = self;
        _choiceTableView.layer.cornerRadius = 6;
        _choiceTableView.layer.masksToBounds = YES;
        _choiceTableView.layer.borderColor = COLOR_BACKGROUND.CGColor;
        _choiceTableView.layer.borderWidth = 1;
        _choiceTableView.bounces = NO;
        _choiceTableView.hidden = YES;
    }
    return _choiceTableView;
}

- (void)addIDImageButton{
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10 + (imageW + 20)*i, 460, imageW, imageW*hw)];
        [self addSubview:btn];
        [btn setTitle:@"+" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:64];
        [btn setTitleColor:COLOR_BACKGROUND forState:UIControlStateNormal];
        btn.layer.cornerRadius = 6;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = COLOR_BACKGROUND.CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addIDWarningLb{
    for (int i = 0; i < 2; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10 + (imageW + 20)*i, 440 + imageW*hw + 25, imageW, 15)];
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
            make.top.mas_equalTo(self.emailChoiceTF.mas_bottom).mas_equalTo(imageW*hw + 60);
        }];
        _nextBtn.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 6;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.tag = 1050;
        [_nextBtn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.choices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [Utils colorRGB:@"#333333"];
    cell.textLabel.text = self.choices[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *choice = self.choices[indexPath.row];
    self.emailChoiceTF.text = choice;
    self.choiceTableView.hidden = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 28;
}


#pragma mark - Method

- (void)buttonClickedAction:(UIButton *)button{
    //950选择邮寄选项
    if (button.tag == 950) {
        [UIView animateWithDuration:0.5 animations:^{
            self.choiceTableView.hidden = self.choiceTableView.hidden==YES ? NO : YES;
        }];
    }
    _RepairCardCallBack(button.tag);
}

@end
