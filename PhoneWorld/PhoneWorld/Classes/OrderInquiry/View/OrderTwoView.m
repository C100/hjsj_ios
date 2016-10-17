//
//  OrderTwoView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderTwoView.h"

@implementation OrderTwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.orderTwoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80) style:UITableViewStyleGrouped];
        self.orderTwoTableView.delegate = self;
        self.orderTwoTableView.dataSource = self;
        [self addSubview:self.orderTwoTableView];
        [self.orderTwoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.bottom.mas_equalTo(0);
        }];
        self.orderTwoTableView.bounces = NO;
        self.orderTwoTableView.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        self.orderTwoTableView.separatorStyle = UITextBorderStyleNone;
        [self.orderTwoTableView registerClass:[OrderTwoTableViewCell class] forCellReuseIdentifier:@"cell"];
        self.orderTwoTableView.tableHeaderView = self.resultNumLB;
    }
    return self;
}

#pragma mark - LazyLoading
- (UILabel *)resultNumLB{
    if (_resultNumLB == nil) {
        _resultNumLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth - 20, 26)];
        _resultNumLB.text = @"共10条";
        _resultNumLB.textColor = [Utils colorRGB:@"#999999"];
        _resultNumLB.font = [UIFont systemFontOfSize:8];
        _resultNumLB.textAlignment = NSTextAlignmentCenter;
    }
    return _resultNumLB;
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell numberLB];
    [cell dateLB];
    [cell typeLB];
    [cell moneyLB];
    [cell phoneLB];
    [cell stateLB];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
