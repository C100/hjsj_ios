//
//  PersonalHomeView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PersonalHomeView.h"
#import "AccountTVCell.h"

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
        
        [self.personalTableView registerClass:[AccountTVCell class] forCellReuseIdentifier:@"acell"];
        
//        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 198)];
//        leftV.backgroundColor = [UIColor whiteColor];
//        [self addSubview:leftV];
        
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
    if (indexPath.section == 0) {
        AccountTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell" forIndexPath:indexPath];
        cell.imageV.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
        cell.titleLB.text = self.titles[indexPath.row];
        cell.titleLB.font = [UIFont systemFontOfSize:16];
        [cell.imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.width.height.mas_equalTo(24);
        }];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
        lb.text = @"退出登录";
        lb.textColor = MainColor;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont systemFontOfSize:18];
        
        [cell.contentView addSubview:lb];
        return cell;
    }
//    cell.separatorInset = UIEdgeInsetsZero;
//    cell.layoutMargins = UIEdgeInsetsZero;
//    cell.preservesSuperviewLayoutMargins = NO;
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
