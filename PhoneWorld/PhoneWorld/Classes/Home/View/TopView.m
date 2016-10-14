//
//  TopView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopView.h"

//#define distanceX (screenWidth - 7*33 - 20)/4.0

#define btnW (screenWidth-20)/self.titles.count

@interface TopView()

@property (nonatomic) CGFloat allWidth;
@property (nonatomic) CGFloat leftDistance;

@end

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.titlesButton = [NSMutableArray array];
        
        for (int i = 0; i < self.titles.count; i++) {
            NSString *str = self.titles[i];
            CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:14] andMaxSize:CGSizeMake(0, 20) andStr:str];
            self.allWidth += size.width;
        }
        
        [self titlesView];
        [self siftView];
        [self lineView];
        
        /*----筛选条件-----*/
        [self orderTimeLB];
        [self orderStateLB];
        [self orderPhoneLB];
    }
    return self;
}

- (UIView *)titlesView{
    if (_titlesView == nil) {
        _titlesView = [[UIView alloc] init];
        [self addSubview:_titlesView];
        [_titlesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(40);
        }];
        
        CGFloat distance = (screenWidth - self.allWidth - 20)/(self.titles.count - 1);
        self.leftDistance = 10;
        for (int i = 0; i < self.titles.count; i ++) {
            NSString *str = self.titles[i];
            CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:14] andMaxSize:CGSizeMake(0, 20) andStr:str];
            CGFloat btnWidth = size.width;
            
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(self.leftDistance, 10, btnWidth, 20);
            btn.tag = 10 + i;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitle:self.titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[Utils colorRGB:@"#333333"] forState:UIControlStateNormal];
            [btn setTitleColor:MainColor forState:UIControlStateSelected];
            btn.selected = NO;
            if (i == 0) {
                btn.selected = YES;
            }
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_titlesView addSubview:btn];
            [self.titlesButton addObject:btn];
            self.leftDistance += (btnWidth + distance);
        }
    }
    return _titlesView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
        _lineView.backgroundColor = COLOR_BACKGROUND;
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titlesView.mas_bottom).mas_equalTo(-1);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return _lineView;
}

- (UIView *)siftView{
    if (_siftView == nil) {
        _siftView = [[UIView alloc] init];
        [self addSubview:_siftView];
        [_siftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titlesView.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(30);
        }];
        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(10, 9, 3, 20)];
        leftV.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_siftView addSubview:leftV];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 50, 15)];
        lb.text = @"筛选条件";
        lb.textColor = [Utils colorRGB:@"#008bd5"];
        lb.font = [UIFont systemFontOfSize:12];
        lb.textAlignment = NSTextAlignmentLeft;
        [_siftView addSubview:lb];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(screenWidth - 30, 14, 20, 10);
        [btn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        btn.tag = 101;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_siftView addSubview:btn];
        btn.transform = CGAffineTransformMakeRotation(M_PI_2*2);
        self.showButton = btn;
    }
    return _siftView;
}

/*---筛选条件----*/
- (UILabel *)orderTimeLB{
    if (_orderTimeLB == nil) {
        _orderTimeLB = [[UILabel alloc] init];
        [self addSubview:_orderTimeLB];
        [_orderTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(self.siftView.mas_bottom).mas_equalTo(8);
            make.height.mas_equalTo(15);
        }];
        _orderTimeLB.textColor = [Utils colorRGB:@"#666666"];
        _orderTimeLB.font = [UIFont systemFontOfSize:12];
        _orderTimeLB.text = @"订单时间：";
    }
    return _orderTimeLB;
}

- (UILabel *)orderStateLB{
    if (_orderStateLB == nil) {
        _orderStateLB = [[UILabel alloc] init];
        [self addSubview:_orderStateLB];
        [_orderStateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(self.orderTimeLB.mas_bottom).mas_equalTo(10);
        }];
        _orderStateLB.textColor = [Utils colorRGB:@"#666666"];
        _orderStateLB.font = [UIFont systemFontOfSize:12];
        _orderStateLB.text = @"订单状态：";
    }
    return _orderStateLB;
}

- (UILabel *)orderPhoneLB{
    if (_orderPhoneLB == nil) {
        _orderPhoneLB = [[UILabel alloc] init];
        [self addSubview:_orderPhoneLB];
        [_orderPhoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(self.orderStateLB.mas_bottom).mas_equalTo(10);
        }];
        _orderPhoneLB.textColor = [Utils colorRGB:@"#666666"];
        _orderPhoneLB.font = [UIFont systemFontOfSize:12];
        _orderPhoneLB.text = @"手机号码：";
    }
    return _orderPhoneLB;
}

#pragma mark - Method

- (void)btnClicked:(UIButton *)button{
    if (button.tag == 101) {
        
    }else{
        for (UIButton *btn in self.titlesButton) {
            btn.selected = NO;
        }
        button.selected = YES;
    }
    _callback(button.tag);
}

@end
