//
//  PasswordManageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PasswordManageView.h"
#import "SettingTableViewCell.h"

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
        [self.passwordManageTableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:@"cell"
         ];
        [self addSubview:self.passwordManageTableView];
    }
    return self;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    if (indexPath.row == self.titles.count - 1) {
        
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _PasswordManagerCallBack(indexPath.row);
}

@end
