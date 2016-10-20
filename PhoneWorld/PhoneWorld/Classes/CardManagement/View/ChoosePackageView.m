//
//  ChoosePackageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChoosePackageView.h"
#import "InformationCollectionViewController.h"

@interface ChoosePackageView ()

@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *titlesTwo;
@property (nonatomic) NSMutableDictionary *userinfosDic;

@end

@implementation ChoosePackageView

- (instancetype)initWithFrame:(CGRect)frame andUserinfos:(NSMutableDictionary *)userinfos
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.titles = @[@"号码：",@"号码归属地：",@"号码状态：",@"网络机制："];
        self.titlesTwo = @[@"套餐选择",@"活动包选择",@"预存金额"];
        self.userinfosDic = userinfos;
        [self addTopStateView];
        [self tableView];
        [self nextButton];
        [self moneyTF];
    }
    return self;
}

- (void)addTopStateView{
    UIView *v = [[UIView alloc] init];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(130);
    }];
    v.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"phoneNumber",@"phoneAddress",@"phoneState",@"networkType"];
    for (int i = 0; i < self.userinfosDic.count; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10 + 30*i, screenWidth - 30, 16)];
        lb.text = [self.titles[i] stringByAppendingString:self.userinfosDic[arr[i]]];
        lb.font = [UIFont systemFontOfSize:14];
        lb.textColor = [Utils colorRGB:@"#333333"];
        
        NSRange range = [lb.text rangeOfString:self.titles[i]];
        
        lb.attributedText = [Utils setTextColor:lb.text FontNumber:[UIFont systemFontOfSize:14] AndRange:range AndColor:[Utils colorRGB:@"#999999"]];

        [v addSubview:lb];
    }
    
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(140);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(119);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.bounces = NO;
    }
    
    return _tableView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tableView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UITextField *)moneyTF{
    if (_moneyTF == nil) {
        _moneyTF = [[UITextField alloc] init];
        [self addSubview:_moneyTF];
        [_moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.left.mas_equalTo(90);
            make.bottom.mas_equalTo(self.tableView.mas_bottom).mas_equalTo(-5);
            make.height.mas_equalTo(30);
        }];
        _moneyTF.borderStyle = UITextBorderStyleRoundedRect;
        _moneyTF.textColor = [Utils colorRGB:@"#666666"];
        _moneyTF.font = [UIFont systemFontOfSize:12];
        _moneyTF.hidden = YES;
        _moneyTF.returnKeyType = UIReturnKeyDone;
        _moneyTF.delegate = self;
        [_moneyTF addTarget:self action:@selector(textFieldStateChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _moneyTF;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([Utils isNumber:self.moneyTF.text]) {
        self.moneyTF.hidden = YES;
        [self endEditing:YES];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = self.moneyTF.text;
        cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
    }else{
        [Utils toastview:@"请输入数字"];
    }
    return YES;
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    
    cell.textLabel.text = self.titlesTwo[indexPath.row];
    cell.detailTextLabel.text = @"请选择";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [Utils colorRGB:@"#666666"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    if (indexPath.row == 2) {
        cell.detailTextLabel.text = @"请输入预存金额";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.textColor = [Utils colorRGB:@"#cccccc"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        self.moneyTF.hidden = NO;
        [self.moneyTF becomeFirstResponder];
    }
}

#pragma mark - Method

- (void)textFieldStateChanged:(UITextField *)textField{
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:2 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexP];
    cell.detailTextLabel.text = textField.text;
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
}

- (void)buttonClickAction:(UIButton *)button{
    /*---跳转到采集信息界面---*/
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:2 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexP];
    if ([Utils isNumber:cell.detailTextLabel.text] && ![cell.detailTextLabel.text isEqualToString:@""]) {
        cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
//        NSLog(@"~~~~~~~~~~%@~~~~~~~~~~",cell.detailTextLabel.text);
        
        [self.userinfosDic addEntriesFromDictionary:@{@"prestoreMoney":self.moneyTF.text}];
        
        UIViewController *viewController = [self viewController];
        InformationCollectionViewController *vc = [InformationCollectionViewController new];
        vc.userinfosDic = self.userinfosDic;
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [Utils toastview:@"请输入预存金额"];
    }
}

@end
