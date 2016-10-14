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
        self.orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, screenWidth - 20, screenHeight - 108 - 80) style:UITableViewStyleGrouped];
        self.orderTableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.orderTableView];
        self.orderTableView.delegate = self;
        self.orderTableView.dataSource = self;
        self.orderTableView.bounces = NO;
        [self.orderTableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:@"cell"];
        self.orderTableView.tableHeaderView = self.resultNumLB;
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
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //得到数据显示
    [cell numberLB];
    [cell nameLB];
    [cell dateLB];
    [cell phoneLB];
    
    cell.contentView.layer.borderWidth = 1;
    if(indexPath.section%2 == 1){
        cell.contentView.layer.borderColor = [Utils colorRGB:@"#fff0aa"].CGColor;
    }else{
        cell.contentView.layer.borderColor = [Utils colorRGB:@"#ddfe98"].CGColor;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 13;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _OrderViewCallBack(indexPath.section);
}

@end
