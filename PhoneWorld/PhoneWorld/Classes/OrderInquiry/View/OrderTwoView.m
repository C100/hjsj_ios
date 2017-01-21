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
        self.orderListArray = [NSMutableArray array];
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
        self.orderTwoTableView.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        self.orderTwoTableView.allowsSelection = NO;
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
        _resultNumLB.text = [NSString stringWithFormat:@"共%ld条",self.orderListArray.count];
        _resultNumLB.textColor = [Utils colorRGB:@"#999999"];
        _resultNumLB.font = [UIFont systemFontOfSize:textfont8];
        _resultNumLB.textAlignment = NSTextAlignmentCenter;
    }
    return _resultNumLB;
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    RechargeListModel *rm = self.orderListArray[indexPath.section];
    cell.rechargeModel = rm;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
