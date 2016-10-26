//
//  ChannelPartnersManageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChannelPartnersManageView.h"
#import "TopView.h"
#import "ChannelPartnersCell.h"
#import "ChannelOrderCell.h"
#import "ScreenView.h"

@interface ChannelPartnersManageView ()

@property (nonatomic) TopView *topView;
@property (nonatomic) UIView *lineView;
@property (nonatomic) ScreenView *screenView;//筛选栏
@property (nonatomic) UIView *grayView;

@property (nonatomic) NSDictionary *contentDic;

@end

@implementation ChannelPartnersManageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        [self topView];
        [self lineView];
        
        //topView的block回调
        __block __weak ChannelPartnersManageView *weakself = self;
        [self.topView setCallback:^(NSInteger tag) {
            //10  11
            NSInteger i = tag - 10;
            [weakself.contentView setContentOffset:CGPointMake(screenWidth*i, 0)];
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = CGRectMake(i*screenWidth/2, 39, screenWidth/2, 1);
                weakself.lineView.frame = frame;
            }];
            if (i == 1) {
                CGRect frame = weakself.topView.frame;
                frame.size.height = 80;
                weakself.topView.frame = frame;
            }else{
                CGRect frame = weakself.topView.frame;
                frame.size.height = 40;
                weakself.topView.frame = frame;
            }
        }];
        
        [self.topView setTopCallBack:^(id obj) {
            // 点击筛选栏时的操作
            weakself.screenView.hidden = weakself.screenView.hidden == YES ? NO : YES;
            weakself.grayView.hidden = weakself.grayView.hidden == YES ? NO : YES;
        }];
        
        [self contentView];
        [self channelPartnersTableView];
        [self orderTableView];
        [self screenView];
        
        //筛选框block回调
        [self.screenView setScreenCallBack:^(NSString *buttonTitle) {
            if ([buttonTitle isEqualToString:@"查询"]) {
                
            }else{
                
            }
        }];
        
        [self grayView];
    }
    return self;
}

#pragma mark - LazyLoading

- (TopView *)topView{
    if (_topView == nil) {
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40) andTitles:@[@"渠道商列表",@"订单记录"]];
        [self addSubview:_topView];
    }
    return _topView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, screenWidth/2, 1)];
        _lineView.backgroundColor = MainColor;
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (UILabel *)channelNumberLB{
    if (_channelNumberLB == nil) {
        _channelNumberLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 26)];
        [self addSubview:_channelNumberLB];
        _channelNumberLB.font = [UIFont systemFontOfSize:8];
        _channelNumberLB.text = @"共20条";
        _channelNumberLB.textColor = [Utils colorRGB:@"#999999"];
        _channelNumberLB.textAlignment = NSTextAlignmentCenter;
        _channelNumberLB.backgroundColor = COLOR_BACKGROUND;
    }
    return _channelNumberLB;
}

- (UILabel *)orderNumberLB{
    if (_orderNumberLB == nil) {
        _orderNumberLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 26)];
        [self addSubview:_orderNumberLB];
        _orderNumberLB.font = [UIFont systemFontOfSize:8];
        _orderNumberLB.text = @"共20条";
        _orderNumberLB.textColor = [Utils colorRGB:@"#999999"];
        _orderNumberLB.textAlignment = NSTextAlignmentCenter;
        _orderNumberLB.backgroundColor = COLOR_BACKGROUND;
    }
    return _orderNumberLB;
}


- (UIScrollView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.bounces = NO;
        _contentView.scrollEnabled = NO;
        _contentView.contentSize = CGSizeMake(screenWidth*2, 0);
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _contentView;
}

- (UITableView *)channelPartnersTableView{
    if (_channelPartnersTableView == nil) {
        _channelPartnersTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64 - 60 - 44) style:UITableViewStyleGrouped];
        [self.contentView addSubview:_channelPartnersTableView];
        _channelPartnersTableView.backgroundColor = COLOR_BACKGROUND;
        _channelPartnersTableView.tag = 100;
        _channelPartnersTableView.delegate = self;
        _channelPartnersTableView.dataSource = self;
        _channelPartnersTableView.bounces = NO;
        _channelPartnersTableView.allowsSelection = NO;
        _channelPartnersTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _channelPartnersTableView.tableHeaderView = self.channelNumberLB;
        [_channelPartnersTableView registerClass:[ChannelPartnersCell class] forCellReuseIdentifier:@"ChannelPartnersCell"];
    }
    return _channelPartnersTableView;
}

- (UITableView *)orderTableView{
    if (_orderTableView == nil) {
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, screenHeight - 64 - 60 - 44) style:UITableViewStyleGrouped];
        [self.contentView addSubview:_orderTableView];
        _orderTableView.backgroundColor = COLOR_BACKGROUND;
        _orderTableView.tag = 200;
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
        _orderTableView.bounces = NO;
        _orderTableView.allowsSelection = NO;
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.tableHeaderView = self.orderNumberLB;
        [_orderTableView registerClass:[ChannelOrderCell class] forCellReuseIdentifier:@"ChannelOrderCell"];
    }
    return _orderTableView;
}

- (ScreenView *)screenView{
    if (_screenView == nil) {
        self.contentDic = @{@"时间":@[@"一个月",@"两个月",@"三个月"],@"手机号码":@"phoneNumber"};
        _screenView = [[ScreenView alloc] initWithFrame:CGRectMake(0, 81, screenWidth, 150) andContent:self.contentDic andLeftTitles:@[@"时间",@"手机号码"] andRightDetails:@[@"请选择",@"请输入手机号码"]];
        [self addSubview:_screenView];
        _screenView.hidden = YES;
    }
    return _screenView;
}

- (UIView *)grayView{
    if (_grayView == nil) {
        _grayView = [[UIView alloc] init];
        [self addSubview:_grayView];
        _grayView.backgroundColor = [UIColor lightGrayColor];
        _grayView.alpha = 0.5;
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(screenHeight - 338);
        }];
        _grayView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissScreenViewAction:)];
        [_grayView addGestureRecognizer:tap];
    }
    return _grayView;
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 100) {//渠道商列表
        ChannelPartnersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelPartnersCell" forIndexPath:indexPath];
        return cell;
    }
    if (tableView.tag == 200) {//订单记录
        ChannelOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelOrderCell" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 100) {
        return 60;
    }else{
        return 90;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 9;
}

#pragma mark - Method

- (void)dismissScreenViewAction:(UITapGestureRecognizer *)tap{
    self.screenView.hidden = self.screenView.hidden == YES ? NO : YES;
    self.grayView.hidden = self.grayView.hidden == YES ? NO : YES;
}

@end
