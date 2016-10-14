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
        self.orderTwoTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, screenWidth - 20, screenHeight - 108 - 80) style:UITableViewStyleGrouped];
        self.orderTwoTableView.delegate = self;
        self.orderTwoTableView.dataSource = self;
        [self addSubview:self.orderTwoTableView];
        self.orderTwoTableView.bounces = NO;
        self.orderTwoTableView.backgroundColor = [UIColor whiteColor];
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
        _resultNumLB.textColor = [Utils colorRGB:@"#666666"];
        _resultNumLB.font = [UIFont systemFontOfSize:10];
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
    
    [cell numberLB];
    [cell dateLB];
    [cell typeLB];
    [cell moneyLB];
    [cell phoneLB];
    [cell stateLB];
    
    cell.contentView.layer.borderWidth = 1;
    if(indexPath.section%2 == 1){
        cell.contentView.layer.borderColor = [Utils colorRGB:@"#fff0aa"].CGColor;
    }else{
        cell.contentView.layer.borderColor = [Utils colorRGB:@"#ddfe98"].CGColor;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 13;
}

@end
