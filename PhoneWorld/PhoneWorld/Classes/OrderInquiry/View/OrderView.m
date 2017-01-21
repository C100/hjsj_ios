//
//  OrderTableView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "OrderView.h"
#import "NormalOrderDetailViewController.h"
#import "OrderListModel.h"
#import "CardTransferListModel.h"

@implementation OrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.orderListArray = [NSMutableArray array];
        
        self.orderTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.titles = @[@"姓名：",@"日期：",@"号码：",@"状态："];
        self.orderTableView.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        [self addSubview:self.orderTableView];
        [self.orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
        }];
        self.orderTableView.delegate = self;
        self.orderTableView.dataSource = self;
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
        _resultNumLB.text = [NSString stringWithFormat:@"共%ld条",_orderListArray.count];
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
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.orderListArray.count > 0) {
        if ([self.orderListArray.firstObject isKindOfClass:[OrderListModel class]]) {
            
            OrderListModel *om = self.orderListArray[indexPath.section];
            
            //得到数据显示
            cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[0],om.customerName];
            
            NSString *dateString = [om.startTime componentsSeparatedByString:@" "].firstObject;
            
            cell.dateLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[1],dateString];
            cell.phoneLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[2],om.number];
            cell.stateLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[3],om.orderStatusName];
            
        }else if([self.orderListArray.firstObject isKindOfClass:[CardTransferListModel class]]){
            //卡片管理中的过户、补卡状态查询
            
            CardTransferListModel *cm = self.orderListArray[indexPath.section];
            NSString *secondTitle = self.titles[1];
            
            
            
            if ([secondTitle isEqualToString:@"号码："]) {
                //得到数据显示
                cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[0],cm.name];
                cell.phoneLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[1],cm.number];
                cell.dateLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[2],cm.state];
                cell.stateLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[3],cm.startName];
            }else{
                //得到数据显示
                //订单查询中的过户补卡查询
                NSString *dateString = [cm.startTime componentsSeparatedByString:@" "].firstObject;
                
                cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[0],cm.name];
                cell.phoneLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[2],cm.number];
                cell.dateLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[1],dateString];
                cell.stateLabel.text = [NSString stringWithFormat:@"%@%@",self.titles[3],cm.startName];
            }
            
        }
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
