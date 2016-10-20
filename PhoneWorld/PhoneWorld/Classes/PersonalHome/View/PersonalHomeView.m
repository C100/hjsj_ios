//
//  PersonalHomeView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PersonalHomeView.h"

@interface PersonalHomeView ()

@property (nonatomic) NSArray *imageNames;
@property (nonatomic) NSArray *titles;

@end

@implementation PersonalHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageNames = @[@"personalInfo",@"unlock",@"news_dark",@"cash",@"setting"];
        self.titles = @[@"个人信息",@"密码管理",@"消息中心",@"佣金统计",@"设置"];
        self.personalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -1, screenWidth, screenHeight - 63) style:UITableViewStyleGrouped];
        self.personalTableView.delegate = self;
        self.personalTableView.dataSource = self;
        self.personalTableView.backgroundColor = COLOR_BACKGROUND;
        self.personalTableView.bounces = NO;
        [self addSubview:self.personalTableView];
    }
    return self;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.titles.count;
            break;
        case 1:
            return 1;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
        cell.textLabel.text = self.titles[indexPath.row];
        cell.textLabel.textColor = [Utils colorRGB:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
        lb.text = @"退出登录";
        lb.textColor = MainColor;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont systemFontOfSize:18];
        
        [cell.contentView addSubview:lb];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            _PersonalHomeCallBack(indexPath.row);
        }
            break;
        case 1:
        {
            _PersonalHomeCallBack(111);
        }
            break;
    }
}

@end
