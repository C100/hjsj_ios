//
//  ICCIDPopView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/12/28.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ICCIDPopView.h"

@implementation ICCIDPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.deviceListArray = [NSMutableArray array];
        
        UIView *backView = [[UIView alloc] init];
        [self addSubview:backView];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.4;
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [backView addGestureRecognizer:tap];
    }
    return self;
}

- (UITableView *)blueTableView{
    if (_blueTableView == nil) {
        _blueTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self addSubview:_blueTableView];
        [_blueTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(400);
        }];
        _blueTableView.tableFooterView = [UIView new];
        [_blueTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _blueTableView;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    [self removeFromSuperview];
}

@end
