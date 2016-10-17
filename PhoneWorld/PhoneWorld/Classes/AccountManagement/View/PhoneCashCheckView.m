//
//  OrderView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneCashCheckView.h"
#import "PhoneCashCheckTVCell.h"

#define leftDistance (screenWidth - 171)/2

@implementation PhoneCashCheckView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        [self tableView];
        [self findButton];
    }
    return self;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40) style:UITableViewStylePlain];
        [self addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UITableView *)resultTableView{
    if (_resultTableView == nil) {
        _resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 300) style:UITableViewStylePlain];
        _resultTableView.tag = 1600;
        [self addSubview:_resultTableView];
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
        _resultTableView.bounces = NO;
        _resultTableView.userInteractionEnabled = NO;
        [_resultTableView registerClass:[PhoneCashCheckTVCell class] forCellReuseIdentifier:@"cell2"];
    }
    return _tableView;
}

- (UIButton *)findButton{
    if (_findButton == nil) {
        _findButton = [[UIButton alloc] init];
        [self addSubview:_findButton];
        [_findButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-leftDistance);
            make.left.mas_equalTo(leftDistance);
            make.top.mas_equalTo(self.tableView.mas_bottom).mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        _findButton.layer.cornerRadius = 20;
        _findButton.layer.masksToBounds = YES;
        _findButton.layer.borderColor = MainColor.CGColor;
        _findButton.layer.borderWidth = 1;
        [_findButton setTitle:@"查询" forState:UIControlStateNormal];
        [_findButton setTitleColor:MainColor forState:UIControlStateNormal];
        _findButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _findButton.tag = 400;
        [_findButton addTarget:self action:@selector(findAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findButton;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1600) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1600) {
        switch (indexPath.row) {
            case 0:
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                }
                cell.textLabel.text = self.userinfos.firstObject;
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                [cell.textLabel setTextColor:[Utils colorRGB:@"#999999"]];
                return cell;
            }
                break;
            case 1:
            {
                PhoneCashCheckTVCell *cell = [[PhoneCashCheckTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
                cell.userinfos = [self.userinfos subarrayWithRange:NSMakeRange(1, 4)];
//                cell.userinfos = @[@"1",@"2",@"3",@"4"];
                return cell;
            }
            case 2:
            {
                PhoneCashCheckTVCell *cell = [[PhoneCashCheckTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
//                cell.userinfos = @[@"11",@"22",@"33",@"44"];
                cell.userinfos = [self.userinfos subarrayWithRange:NSMakeRange(5, 4)];
                return cell;
            }
                break;
        }
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"手机号码";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [Utils colorRGB:@"#666666"];
        cell.detailTextLabel.text = @"请输入手机号码";
        cell.detailTextLabel.textColor = [Utils colorRGB:@"#cccccc"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
        UITextField *tf = [[UITextField alloc] init];
        [cell.contentView addSubview:tf];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(80);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(5);
        }];
        tf.delegate = self;
        tf.hidden = YES;
        tf.tag = 2000+indexPath.row;
        [tf setReturnKeyType:UIReturnKeyDone];
        [tf setFont:[UIFont systemFontOfSize:12]];
        self.inputTextField = tf;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.inputTextField.hidden = NO;
    [self.inputTextField becomeFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1600) {
        switch (indexPath.row) {
            case 0:
                return 40;
                break;
                
            default:
                return 129;
                break;
        }
    }
    return 40;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = textField.text;
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
    [textField resignFirstResponder];
    textField.hidden = YES;
    self.phoneNum = cell.detailTextLabel.text;
    return YES;
}

#pragma mark - Method 
- (void)findAction:(UIButton *)button{
    [self endEditing:YES];
    self.phoneNum = self.inputTextField.text;
    _orderCallBack(button.tag);
}

@end
