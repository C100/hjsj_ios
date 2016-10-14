//
//  SettingView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "SettingView.h"

@interface SettingView ()

@property (nonatomic) NSArray *titles;

@end

@implementation SettingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = @[@"意见反馈",@"清除缓存",@"APP评分",@"关于我们"];
        self.settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        self.settingTableView.delegate = self;
        self.settingTableView.dataSource = self;
        self.settingTableView.tableFooterView = [UIView new];
        self.settingTableView.bounces = NO;
        self.settingTableView.backgroundColor = COLOR_BACKGROUND;
        [self addSubview:self.settingTableView];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    if (indexPath.row == 1) {
//        //计算缓存
//        [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.3fMB",totalSize/1024.0/1024.0];
//        }];
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _SettingCallBack(indexPath.row);
}

@end
