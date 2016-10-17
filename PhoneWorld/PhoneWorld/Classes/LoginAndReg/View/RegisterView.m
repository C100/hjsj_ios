//
//  RegisterView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RegisterView.h"
#import "RegisterOneTVCell.h"

@interface RegisterView ()

@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSArray *details;
@property (nonatomic) NSArray *channelType;

@end

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftTitles = @[@"＊用户名",@"＊密码",@"＊真实姓名",@"＊身份证号码",@"＊手机号码",@"＊验证码",@"邮箱",@"＊渠道类型",@"＊渠道名称",@"＊上级推荐码"];
        self.details = @[@"请输入用户名",@"请输入密码",@"请输入真实姓名",@"请输入身份证号码",@"请输入手机号",@"请输入验证码",@"请输入有效邮箱",@"请选择",@"请输入渠道名称",@"请输入上级推荐码"];
        self.channelType = @[@"总代理",@"一级代理",@"二级代理",@"渠道商"];
        self.inputTFs = [NSMutableArray array];
        self.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        self.registerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -1, screenWidth, screenHeight - 64) style:UITableViewStyleGrouped];
        self.registerTableView.delegate = self;
        self.registerTableView.dataSource = self;
        self.registerTableView.bounces = NO;
        [self.registerTableView registerClass:[RegisterOneTVCell class] forCellReuseIdentifier:@"regCell"];
        [self addSubview:self.registerTableView];
    }
    return self;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 10;
            break;
            
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            }
            [cell.textLabel setTextColor:[Utils colorRGB:@"#666666"]];
            cell.textLabel.text = self.leftTitles[indexPath.row];
            NSRange range = [self.leftTitles[indexPath.row] rangeOfString:@"＊"];
            [self setTextColor:cell.textLabel FontNumber:[UIFont systemFontOfSize:14] AndRange:range AndColor:[Utils colorRGB:@"#ec6c00"]];
            cell.detailTextLabel.text = self.details[indexPath.row];
            if ([self.leftTitles[indexPath.row] isEqualToString:@"＊渠道类型"]) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            if ([self.leftTitles[indexPath.row] isEqualToString:@"＊验证码"]) {
                cell.detailTextLabel.text = @"";
                UIButton *identifyingButton = [[UIButton alloc] init];
                [identifyingButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [identifyingButton setTitleColor:[Utils colorRGB:@"#666666"] forState:UIControlStateNormal];
                identifyingButton.titleLabel.font = [UIFont systemFontOfSize:12];
                identifyingButton.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
                identifyingButton.layer.cornerRadius = 6;
                identifyingButton.layer.masksToBounds = YES;
                identifyingButton.tag = 1300;
                [identifyingButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:identifyingButton];
                [identifyingButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(8);
                    make.right.mas_equalTo(-15);
                    make.height.mas_equalTo(24);
                    make.width.mas_equalTo(70);
                }];
                self.identifyingButton = identifyingButton;
                
                UILabel *lb = [[UILabel alloc] init];
                lb.text = @" 情输入验证码";
                lb.font = [UIFont systemFontOfSize:12];
                lb.textColor = [Utils colorRGB:@"#cccccc"];
                [cell.contentView addSubview:lb];
                [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(identifyingButton.mas_left).mas_equalTo(-20);
                    make.centerY.mas_equalTo(0);
                }];
                lb.textAlignment = NSTextAlignmentRight;
            }
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            [cell.detailTextLabel setTextColor:[Utils colorRGB:@"#cccccc"]];
            
            UITextField *tf = [[UITextField alloc] init];
            [cell.contentView addSubview:tf];
            tf.borderStyle = UITextBorderStyleRoundedRect;
            if(indexPath.row == 5){
                [tf mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(110);
                    make.right.mas_equalTo(self.identifyingButton.mas_left).mas_equalTo(-10);
                    make.height.mas_equalTo(30);
                    make.top.mas_equalTo(5);
                }];
            }else{
                [tf mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(110);
                    make.right.mas_equalTo(-10);
                    make.height.mas_equalTo(30);
                    make.top.mas_equalTo(5);
                }];
            }
            [self.inputTFs addObject:tf];
            tf.delegate = self;
            tf.hidden = YES;
            [tf setReturnKeyType:UIReturnKeyDone];
            [tf setFont:[UIFont systemFontOfSize:12]];
            return cell;
        }
            break;
        case 1:
        {
            RegisterOneTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"regCell"];
            
            return cell;
        }
            break;
        case 2:
        {
            
        }
            break;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }
    if (indexPath.section == 1) {
        return 127;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 7) {
                //选择渠类型
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"渠道类型" message:nil preferredStyle:UIAlertControllerStyleAlert];
                for (int i = 0; i < self.channelType .count; i ++) {
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.channelType[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        cell.detailTextLabel.text = self.channelType[i];
                        cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
                    }];
                    [ac addAction:action1];
                }
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
            }else{
                for (UITextField *textF in self.inputTFs) {
                    textF.hidden = YES;
                }
                UITextField *tf = self.inputTFs[indexPath.row];
                tf.hidden = NO;
                [tf becomeFirstResponder];
            }
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger row = textField.tag - 2000;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *cell = [self.registerTableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = textField.text;
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
    [textField resignFirstResponder];
    textField.hidden = YES;
    return YES;
}

#pragma mark - Method
- (void)buttonClickAction:(UIButton *)button{
    //1300
    NSLog(@"---------register------");
}

//设置不同字体颜色
-(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = str;
}

@end
