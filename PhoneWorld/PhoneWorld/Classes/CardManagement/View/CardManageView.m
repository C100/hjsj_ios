//
//  CardManageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardManageView.h"
#import "AccountTVCell.h"

@interface CardManageView ()

@property (nonatomic) NSArray *imageNames;
@property (nonatomic) NSArray *titles;

@end

@implementation CardManageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self imageNames];
        self.titles = @[@"成卡开户",@"白卡开户",@"过户",@"补卡",@"过户、补卡进度查询"];
        [self cardTableView];
    }
    return self;
}

- (UITableView *)cardTableView{
    if (_cardTableView == nil) {
        _cardTableView = [[UITableView alloc] init];
        [self addSubview:_cardTableView];
        [_cardTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        _cardTableView.backgroundColor = COLOR_BACKGROUND;
        _cardTableView.tableFooterView = [UIView new];
        _cardTableView.delegate = self;
        _cardTableView.dataSource = self;
        [_cardTableView registerClass:[AccountTVCell class] forCellReuseIdentifier:@"acell"];
        _cardTableView.bounces = NO;
    }
    return _cardTableView;
}

- (NSArray *)imageNames{
    if (_imageNames == nil) {
        _imageNames = @[@"41",@"42",@"43",@"44",@"45"];
    }
    return _imageNames;
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    cell.titleLB.text = self.titles[indexPath.row];
    
    if (indexPath.row == self.titles.count-1) {
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _myCallBack(indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
