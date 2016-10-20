//
//  PasswordManageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PasswordManageView.h"

@interface PasswordManageView ()

@property (nonatomic) NSArray *titles;

@end

@implementation PasswordManageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = @[@"登录密码修改",@"支付密码创建",@"支付密码修改"];
        self.passwordManageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -1, screenWidth, screenHeight - 63)];
        self.passwordManageTableView.delegate = self;
        self.passwordManageTableView.dataSource = self;
        self.passwordManageTableView.bounces = NO;
        self.passwordManageTableView.tableFooterView = [UIView new];
        self.passwordManageTableView.backgroundColor = COLOR_BACKGROUND;
        [self addSubview:self.passwordManageTableView];
    }
    return self;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.textColor = [Utils colorRGB:@"#333333"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _PasswordManagerCallBack(indexPath.row);
}

@end
