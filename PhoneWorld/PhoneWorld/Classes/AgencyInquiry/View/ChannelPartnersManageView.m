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

#import "ChannelPartnersManageViewController.h"

@interface ChannelPartnersManageView ()

@property (nonatomic) TopView *topView;
@property (nonatomic) UIView *lineView;
@property (nonatomic) ScreenView *screenView;//筛选栏
@property (nonatomic) UIView *grayView;

@property (nonatomic) NSDictionary *contentDic;
@property (nonatomic) NSArray *leftTitles;

@property (nonatomic) BOOL isInquiried;

@end

@implementation ChannelPartnersManageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"时间",@"工号"];
        self.isInquiried = NO;
        
        self.orderArray = [NSMutableArray array];
        self.channelArray = [NSMutableArray array];
        
        [self topView];
        [self lineView];
        
        //topView的block回调
        __block __weak ChannelPartnersManageView *weakself = self;
        [self.topView setCallback:^(NSInteger tag) {
            //10  11
            NSInteger i = tag - 10;
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = CGRectMake(i*screenWidth/2, 39, screenWidth/2, 1);
                weakself.lineView.frame = frame;
            }];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            if (i == 1) {
                NSInteger i1 = [ud integerForKey:@"qdsOrderList"];
                i1 = i1 + 1;
                [ud setInteger:i1 forKey:@"qdsOrderList"];
                [ud synchronize];
                [weakself.orderTableView.mj_header beginRefreshing];
                
                CGFloat height = 80;
                if (weakself.isInquiried == YES) {
                    height = 108;
                }
                CGRect frame = weakself.topView.frame;
                frame.size.height = height;
                weakself.topView.frame = frame;//修改topView的frame
                
                weakself.channelPartnersTableView.hidden = YES;
                weakself.orderTableView.hidden = NO;
            }else{
                NSInteger i0 = [ud integerForKey:@"qdsList"];
                i0 = i0 + 1;
                [ud setInteger:i0 forKey:@"qdsList"];
                [ud synchronize];
                [weakself.channelPartnersTableView.mj_header beginRefreshing];

                CGRect frame = weakself.topView.frame;
                frame.size.height = 40;
                weakself.topView.frame = frame;
                
                weakself.channelPartnersTableView.hidden = NO;
                weakself.orderTableView.hidden = YES;
                
                CGRect frameCh = weakself.channelPartnersTableView.frame;
                frameCh = CGRectMake(0, 40, screenWidth, screenHeight - 108 - 40);
                weakself.channelPartnersTableView.frame = frameCh;
                
                weakself.screenView.hidden = YES;
                weakself.grayView.hidden = YES;
            }
        }];
        
        [self.topView setTopCallBack:^(id obj) {
            [weakself endEditing:YES];

            if (weakself.screenView.hidden == NO) {
                weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
                [UIView animateWithDuration:0.3 animations:^{
                    weakself.screenView.alpha = 0;
                    weakself.grayView.alpha = 0;
                } completion:^(BOOL finished) {
                    weakself.screenView.hidden = YES;
                    weakself.grayView.hidden = YES;
                }];
            }else{
                weakself.topView.showButton.transform = CGAffineTransformIdentity;
                weakself.screenView.hidden = NO;
                weakself.grayView.hidden = NO;
                weakself.screenView.alpha = 0;
                weakself.grayView.alpha = 0;
                [UIView animateWithDuration:0.3 animations:^{
                    weakself.screenView.alpha = 1;
                    weakself.grayView.alpha = 0.5;
                } completion:^(BOOL finished) {
                }];
            }
        }];
        
        [self channelPartnersTableView];
        [self orderTableView];
        [self screenView];
        
        //筛选框block回调  返回数组查询
        [self.screenView setScreenCallBack:^(NSDictionary *conditions, NSString *string) {
            /*
             conditions查询条件
             */
            [weakself endEditing:YES];
            
            if (conditions.count != 0) {
                [ChannelPartnersManageViewController sharedChannelPartnersManageViewController].conditions = conditions;
                [[ChannelPartnersManageViewController sharedChannelPartnersManageViewController].channelView.orderTableView.mj_header beginRefreshing];
            }
            
            weakself.isInquiried = YES;
            
            if (conditions.count == 0) {
                
            }else{
                for (int i = 0; i < 2; i ++) {
                    UILabel *lb = weakself.topView.resultArr[i];
                    
                    NSString *leftTitleString = weakself.leftTitles[i];
                    
                    if (conditions[leftTitleString]) {
                        lb.text = [NSString stringWithFormat:@"%@：%@",weakself.leftTitles[i],conditions[leftTitleString]];
                    }else{
                        lb.text = [NSString stringWithFormat:@"%@：无",weakself.leftTitles[i]];
                    }
                    
                    lb.font = [UIFont systemFontOfSize:14*screenWidth/414.0];
                }
                
                [weakself.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.mas_equalTo(0);
                    make.top.mas_equalTo(0);
                    make.height.mas_equalTo(108);
                }];
            }
            
            if ([string isEqualToString:@"查询"]) {
                weakself.screenView.hidden = YES;
                weakself.grayView.hidden = YES;
                weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
            }else{
                //重置
                [weakself.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.mas_equalTo(0);
                    make.top.mas_equalTo(0);
                    make.height.mas_equalTo(80);
                }];
            }
        }];
        
        
        
        
        [self.screenView setScreenDismissCallBack:^(id obj) {
            
            weakself.screenView.datePickerView.hidden = YES;
            weakself.screenView.pickerView.hidden = YES;
            weakself.screenView.backPickView.hidden = YES;
            weakself.screenView.cancelButton.hidden = YES;
            weakself.screenView.sureButton.hidden = YES;
            
//            [UIView animateWithDuration:0.5 animations:^{
//                weakself.screenView.datePickerView.alpha = 0;
//                weakself.screenView.pickerView.alpha = 0;
//                weakself.screenView.backPickView.alpha = 0;
//                weakself.screenView.cancelButton.alpha = 0;
//                weakself.screenView.sureButton.alpha = 0;
//                
//            } completion:^(BOOL finished) {
//                weakself.screenView.datePickerView.hidden = YES;
//                weakself.screenView.pickerView.hidden = YES;
//                weakself.screenView.backPickView.hidden = YES;
//                weakself.screenView.cancelButton.hidden = YES;
//                weakself.screenView.sureButton.hidden = YES;
//            }];
//            
        }];
        
        [self grayView];
    }
    return self;
}

#pragma mark - LazyLoading

- (TopView *)topView{
    if (_topView == nil) {
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40) andTitles:@[@"渠道商列表",@"渠道商开户量"] andResultTitles:@[@"时间：",@"工号："]];
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
        _channelNumberLB.font = [UIFont systemFontOfSize:textfont8];
        _channelNumberLB.text = @"共0条";
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
        _orderNumberLB.font = [UIFont systemFontOfSize:textfont8];
        _orderNumberLB.text = @"共0条";
        _orderNumberLB.textColor = [Utils colorRGB:@"#999999"];
        _orderNumberLB.textAlignment = NSTextAlignmentCenter;
        _orderNumberLB.backgroundColor = COLOR_BACKGROUND;
    }
    return _orderNumberLB;
}

- (UITableView *)channelPartnersTableView{
    if (_channelPartnersTableView == nil) {
        _channelPartnersTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:_channelPartnersTableView];
        [_channelPartnersTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        _channelPartnersTableView.backgroundColor = COLOR_BACKGROUND;
        _channelPartnersTableView.tag = 100;
        _channelPartnersTableView.delegate = self;
        _channelPartnersTableView.dataSource = self;
        _channelPartnersTableView.allowsSelection = NO;
        _channelPartnersTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _channelPartnersTableView.tableHeaderView = self.channelNumberLB;
        [_channelPartnersTableView registerClass:[ChannelPartnersCell class] forCellReuseIdentifier:@"ChannelPartnersCell"];
    }
    return _channelPartnersTableView;
}

- (UITableView *)orderTableView{
    if (_orderTableView == nil) {
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:_orderTableView];
        [_orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        _orderTableView.backgroundColor = COLOR_BACKGROUND;
        _orderTableView.tag = 200;
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
        _orderTableView.allowsSelection = NO;
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.tableHeaderView = self.orderNumberLB;
        [_orderTableView registerClass:[ChannelOrderCell class] forCellReuseIdentifier:@"ChannelOrderCell"];
        _orderTableView.hidden = YES;
    }
    return _orderTableView;
}

- (ScreenView *)screenView{
    if (_screenView == nil) {
        self.contentDic = @{@"时间":@[@"一个月",@"两个月",@"三个月",@"四个月",@"五个月",@"六个月"],@"手机号码":@"phoneNumber"};
        _screenView = [[ScreenView alloc] initWithFrame:CGRectMake(0, 81, screenWidth, 150) andContent:self.contentDic andLeftTitles:self.leftTitles andRightDetails:@[@"请选择",@"请输入工号"]];
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
    if (tableView.tag == 100) {
        return self.channelArray.count;
    }else if(tableView.tag == 200){
        return self.orderArray.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 100) {//渠道商列表
        ChannelPartnersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelPartnersCell" forIndexPath:indexPath];
        cell.channelModel = self.channelArray[indexPath.section];
        return cell;
    }
    //订单记录
    ChannelOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelOrderCell" forIndexPath:indexPath];
    cell.orderCountModel = self.orderArray[indexPath.section];
    return cell;
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
    __block __weak ChannelPartnersManageView *weakself = self;
    [self endEditing:YES];
    if (weakself.screenView.hidden == NO) {
        weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
        [UIView animateWithDuration:0.3 animations:^{
            weakself.screenView.alpha = 0;
            weakself.grayView.alpha = 0;
        } completion:^(BOOL finished) {
            weakself.screenView.hidden = YES;
            weakself.grayView.hidden = YES;
        }];
    }else{
        weakself.topView.showButton.transform = CGAffineTransformIdentity;
        weakself.screenView.hidden = NO;
        weakself.grayView.hidden = NO;
        weakself.screenView.alpha = 0;
        weakself.grayView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            weakself.screenView.alpha = 1;
            weakself.grayView.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
    }
}

@end
