//
//  ChoosePackageTableView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChoosePackageTableView.h"
#import "ChoosePackageDetailViewController.h"
#import "ChoosePackageDetailView.h"

@interface ChoosePackageTableView ()<ChoosePackageDetailViewDelegate>
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
    
    if (indexPath.row == 2) {
        self.inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        self.inputView.textField.placeholder = @"请输入预存金额";
        self.inputView.leftLabel.text = @"预存金额";
        [cell.contentView addSubview:self.inputView];
    }else{
        cell.textLabel.text = self.titles[indexPath.row];
        cell.detailTextLabel.text = @"请选择";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [Utils colorRGB:@"#666666"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    if (indexPath.row == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
     套餐选择
     活动包选择
     */
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.currentCell = cell;
    
    UIViewController *viewController = [self viewController];

    switch (indexPath.row) {
        case 0:
        {
            ChoosePackageDetailViewController *vc = [[ChoosePackageDetailViewController alloc] init];
            vc.title = @"套餐选择";
            vc.packageTableView = self;
            [viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            ChoosePackageDetailViewController *vc = [[ChoosePackageDetailViewController alloc] init];
            vc.title = @"活动包选择";
            vc.packageTableView = self;
            [viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}

#pragma mark - Method
- (void)textFieldStateChanged:(UITextField *)textField{
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:2 inSection:0];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexP];
    cell.detailTextLabel.text = textField.text;
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
}

- (void)getPackage:(NSString *)package{
    self.currentCell.detailTextLabel.text = package;
}


@end
