//
//  MessageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/2.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "MessageView.h"
#import "MessageTCell.h"
#import "MessageModel.h"
#import "MessageDetailViewController.h"
#import "MessageDetailModel.h"

@interface MessageView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.messagesArray = [NSMutableArray array];
        [self messageTableView];
    }
    return self;
}

- (UITableView *)messageTableView{
    if (_messageTableView == nil) {
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) style:UITableViewStylePlain];
        [self addSubview:_messageTableView];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.backgroundColor = COLOR_BACKGROUND;
        [_messageTableView registerClass:[MessageTCell class] forCellReuseIdentifier:@"cell"];
        _messageTableView.tableFooterView = [UIView new];
    }
    return _messageTableView;
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MessageModel *mm = self.messagesArray[indexPath.row];
    cell.messageModel = mm;
    
    cell.preservesSuperviewLayoutMargins = YES;//防止复用

    if (indexPath.row == self.messagesArray.count - 1) {
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageModel *mm = self.messagesArray[indexPath.row];
    
    MessageDetailViewController *detailVC = [[MessageDetailViewController alloc] init];
    detailVC.message_id = mm.message_id;
    UIViewController *viewController = [self viewController];
    [viewController.navigationController pushViewController:detailVC animated:YES];
}

@end
