//
//  ChoosePackageTableView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChoosePackageTableView.h"

@interface ChoosePackageTableView ()
@property (nonatomic) NSArray *titles;
@end

@implementation ChoosePackageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titles = @[@"套餐选择",@"活动包选择",@"预存金额"];
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
        self.bounces = NO;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    
    cell.textLabel.text = self.titles[indexPath.row];
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
    _ChoosePackageCallBack(indexPath.row);
}

#pragma mark - Method
- (void)textFieldStateChanged:(UITextField *)textField{
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:2 inSection:0];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexP];
    cell.detailTextLabel.text = textField.text;
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
}

@end
