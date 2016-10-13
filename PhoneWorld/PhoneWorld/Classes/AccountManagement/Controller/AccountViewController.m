//
//  AccountViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/11.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountTVCell.h"
#import "PhoneCashCheckViewController.h"
#import "CheckAndTopViewController.h"
#import "TopCallMoneyViewController.h"

@interface AccountViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *myTableView;
@property (nonatomic) NSArray *imageNames;
@property (nonatomic) NSArray *titles;
@end

@implementation AccountViewController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageNames];
    [self titles];
    [self myTableView];
    self.myTableView.tableFooterView = [UIView new];
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountTVCell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    cell.titleLB.text = self.titles[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            PhoneCashCheckViewController *vc = [PhoneCashCheckViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            CheckAndTopViewController *vc = [CheckAndTopViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            TopCallMoneyViewController *vc = [TopCallMoneyViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
            
            break;
    }
}

#pragma mark - LazyLoading
- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 108) style:UITableViewStylePlain];
        [_myTableView registerClass:[AccountTVCell class]  forCellReuseIdentifier:@"AccountTVCell"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.bounces = NO;
        _myTableView.backgroundColor = [Utils colorRGB:@"#eaeaea"];
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}

- (NSArray *)imageNames{
    if (_imageNames == nil) {
        _imageNames = @[@"Group 13",@"Group 14",@"Group 15",@"Group 16"];
    }
    return _imageNames;
}

- (NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@"号码余额查询",@"余额查询与充值",@"话费充值",@"充值查询"];
    }
    return _titles;
}

@end
