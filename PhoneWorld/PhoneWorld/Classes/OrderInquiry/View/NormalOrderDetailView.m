//
//  NormalOrderView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "NormalOrderDetailView.h"

#define imageWH 354/225.0

@interface NormalOrderDetailView ()

@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *firstTitles;
@property (nonatomic) NSArray *secondTitles;
@property (nonatomic) NSArray *thirdTitles;

@end

@implementation NormalOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = @[@"订单信息",@"资费信息",@"客户信息"];
        self.firstTitles = @[@"    订单编号：",@"    订单时间：",@"    订单类型：",@"    订单状态：",@"    审核时间：",@"    审核结果：",@"    开户号码："];
        self.secondTitles = @[@"    预存金额：",@"    活动包：",@"    靓号规则：",@"    套餐选择：",@"    起止日期："];
        self.thirdTitles = @[@"    姓名：",@"    身份证号码：",@"    身份证地址：浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市浙江省杭州市"];
        self.titleButtons = [NSMutableArray array];
        self.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        [self headView];
        [self moveView];
        [self contentView];
        [self firstView];
        [self secondView];
        [self thirdView];
    }
    return self;
}

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        for (int i = 0; i < self.titles.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth/3.0)*i, 0, screenWidth/3.0, 40)];
            [button setTitle:self.titles[i] forState:UIControlStateNormal];
            [_headView addSubview:button];
            [button setTitleColor:[Utils colorRGB:@"#333333"] forState:UIControlStateNormal];
            [button setTitleColor:MainColor forState:UIControlStateSelected];
            button.tag = 1130+i;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                button.selected = YES;
            }
            [self.titleButtons addObject:button];
        }
    }
    return _headView;
}

- (UIView *)moveView{
    if (_moveView == nil) {
        _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, screenWidth/3, 1)];
        [self addSubview:_moveView];
        _moveView.backgroundColor = MainColor;
    }
    return _moveView;
}

- (UIScrollView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.tag = 1500;
        _contentView.delegate = self;
        _contentView.contentSize = CGSizeMake(screenWidth*3, 0);
        _contentView.bounces = NO;
        _contentView.pagingEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.headView.mas_bottom).mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _contentView;
}

- (UIView *)firstView{
    if (_firstView == nil) {
        _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 104)];
        [self.contentView addSubview:_firstView];
        _firstView.backgroundColor = COLOR_BACKGROUND;
        
        for (int i = 0; i < self.firstTitles.count; i++) {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, (14+16)*i, screenWidth, 30)];
            lb.backgroundColor = [UIColor whiteColor];
            [_firstView addSubview:lb];
            lb.text = self.firstTitles[i];
            lb.font = [UIFont systemFontOfSize:14];
            lb.textColor = [Utils colorRGB:@"#999999"];
        }
        
    }
    return _firstView;
}

- (UIView *)secondView{
    if (_secondView == nil) {
        _secondView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, screenHeight - 104)];
        [self.contentView addSubview:_secondView];
        _secondView.backgroundColor = COLOR_BACKGROUND;
        
        for (int i = 0; i < self.secondTitles.count; i++) {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, (14+16)*i, screenWidth, 30)];
            lb.backgroundColor = [UIColor whiteColor];
            [_secondView addSubview:lb];
            lb.text = self.secondTitles[i];
            lb.font = [UIFont systemFontOfSize:14];
            lb.textColor = [Utils colorRGB:@"#999999"];
        }
    }
    return _secondView;
}

- (UIScrollView *)thirdView{
    if (_thirdView == nil) {
        _thirdView = [[UIScrollView alloc] initWithFrame:CGRectMake(screenWidth*2, 0, screenWidth, screenHeight - 104)];
        [self.contentView addSubview:_thirdView];
        _thirdView.backgroundColor = COLOR_BACKGROUND;
        _thirdView.bounces = NO;
        
        UILabel *lastLb = nil;
        for (int i = 0; i < self.thirdTitles.count; i++) {
            CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:14] andMaxSize:CGSizeMake(screenWidth, 0) andStr:self.thirdTitles[i]];
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, (14+16)*i, screenWidth, size.height+14)];
            lb.backgroundColor = [UIColor whiteColor];
            [_thirdView addSubview:lb];
            lb.text = self.thirdTitles[i];
            lb.font = [UIFont systemFontOfSize:14];
            lb.textColor = [Utils colorRGB:@"#999999"];
            lb.numberOfLines = 0;
            lastLb = lb;
        }
        
        UIView *v = [[UIView alloc] init];
        [_thirdView addSubview:v];
        v.backgroundColor = [UIColor whiteColor];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastLb.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30+2*(screenWidth - 30)/(354/225.0));
            make.bottom.mas_equalTo(-10);
        }];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];

        
        UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, screenWidth - 30, (screenWidth - 30)/(354/225.0))];
        imageV1.image = [UIImage imageNamed:@"identifyCard2"];
//        [imageV1 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"identifyCard2"]];
        [v addSubview:imageV1];
        [imageV1 addGestureRecognizer:tap1];
        imageV1.userInteractionEnabled = YES;
        
        UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20+(screenWidth - 30)/(354/225.0), screenWidth - 30, (screenWidth - 30)/(354/225.0))];
        imageV2.image = [UIImage imageNamed:@"identifyCard1"];
//        [imageV2 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"identifyCard2"]];
        [v addSubview:imageV2];
        [imageV2 addGestureRecognizer:tap2];
        imageV2.userInteractionEnabled = YES;
    }
    return _thirdView;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 1500) {
        CGRect frame = self.moveView.frame;
        frame.origin.x = scrollView.contentOffset.x/3.0;
        self.moveView.frame = frame;
        NSInteger i =  scrollView.contentOffset.x/screenWidth;
        for (UIButton *b in self.titleButtons) {
            b.selected = NO;
        }
        UIButton *button = [self viewWithTag:1130+i];
        button.selected = YES;
    }
}

#pragma mark - Method
- (void)buttonClickedAction:(UIButton *)button{
    //1130  1131  1132
    NSInteger i = button.tag - 1130;
    for (UIButton *b in self.titleButtons) {
        b.selected = NO;
    }
    button.selected = YES;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.moveView.frame;
        frame.origin.x = i*screenWidth/3.0;
        self.moveView.frame = frame;
        self.contentView.contentOffset = CGPointMake(screenWidth*i, 0);
    }];
}

- (void)imageTapAction:(UITapGestureRecognizer *)tap{
    UIImageView *imageV = (UIImageView *)tap.view;
    [PhotoBroswerVC show:[UIApplication sharedApplication].keyWindow.rootViewController type:PhotoBroswerVCTypeZoom index:0 photoModelBlock:^NSArray *{
        //创建多大容量数组
        NSMutableArray *modelsM = [NSMutableArray array];
        PhotoModel *pbModel=[[PhotoModel alloc] init];
        pbModel.mid = 11;
        //设置查看大图的时候的图片
        pbModel.image = imageV.image;
        pbModel.sourceImageView = imageV;//点击返回时图片做动画用
        [modelsM addObject:pbModel];
        return modelsM;
    }];
}

@end
