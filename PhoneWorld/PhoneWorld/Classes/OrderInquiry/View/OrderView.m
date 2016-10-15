//
//  OrderTableView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderView.h"
#import "NormalOrderDetailViewController.h"

@implementation OrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108 - 80) style:UITableViewStyleGrouped];
        self.orderTableView.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        [self addSubview:self.orderTableView];
        self.orderTableView.delegate = self;
        self.orderTableView.dataSource = self;
        self.orderTableView.bounces = NO;
        [self.orderTableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:@"cell"];
        self.orderTableView.tableHeaderView = self.resultNumLB;
        self.orderTableView.separatorStyle = UITextBorderStyleNone;
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
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //得到数据显示
    [cell numberLB];
    [cell nameLB];
    [cell dateLB];
    [cell phoneLB];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _OrderViewCallBack(indexPath.section);
}

@end
