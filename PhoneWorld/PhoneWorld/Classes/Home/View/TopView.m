//
//  TopView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopView.h"

#define btnW (screenWidth-20)/self.titles.count

@interface TopView()

@property (nonatomic) CGFloat allWidth;
@property (nonatomic) CGFloat leftDistance;

@property (nonatomic) UIView *titlesView;
@property (nonatomic) NSArray *titles;//标题名称

@property (nonatomic) UIView *siftView;//筛选栏
@property (nonatomic) UIView *lineView;

@property (nonatomic) UIView *resultView;
@property (nonatomic) NSArray *resultViewLeftTitles;

@end

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andResultTitles:(NSArray *)resultTitlesArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.titlesButton = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < self.titles.count; i++) {
            NSString *str = self.titles[i];
            CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont14] andMaxSize:CGSizeMake(0, 20) andStr:str];
            self.allWidth += size.width;
        }
        self.resultViewLeftTitles = @[@"起始时间：",@"截止时间：",@"订单状态：",@"手机号码："];
        self.resultArr = [NSMutableArray array];
        self.resultTitlesArray = [NSArray array];
        self.resultTitlesArray = resultTitlesArray;
        [self titlesView];
        [self siftView];
        [self lineView];
        [self resultView];
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
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = 10 + i;
            btn.titleLabel.font = [UIFont systemFontOfSize:textfont14];
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
            
            if (self.titles.count == 3 || self.titles.count == 2 || self.titles.count == 4) {
                //topview上的button均分
                btn.frame = CGRectMake(i*screenWidth/self.titles.count, 0, screenWidth/self.titles.count, 40);
                
                [self.titlesButton addObject:btn];
            }else{
                //topView上的title string间距均分
                CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont14] andMaxSize:CGSizeMake(0, 20) andStr:str];
                CGFloat btnWidth = size.width;
                
                btn.frame = CGRectMake(self.leftDistance, 0, btnWidth, 40);

                self.leftDistance += (btnWidth + distance);
            }
            
            if (i == 0) {
                self.currentButton = btn;
            }
            
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
        
        UITapGestureRecognizer *tapSiftGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSiftAction:)];
        [_siftView addGestureRecognizer:tapSiftGR];
        
        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(10, 9, 3, 20)];
        leftV.backgroundColor = [Utils colorRGB:@"#008bd5"];
        [_siftView addSubview:leftV];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 100, 15)];
        lb.text = @"筛选条件";
        lb.textColor = [Utils colorRGB:@"#008bd5"];
        lb.font = [UIFont systemFontOfSize:textfont12];
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

- (UIView *)resultView{
    if (_resultView == nil) {
        _resultView = [[UIView alloc] init];
        [self addSubview:_resultView];
        [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.siftView.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(50);
        }];
        for (int i = 0; i < self.resultTitlesArray.count; i++) {
            NSInteger queue = i%2;
            NSInteger line = i/2;
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15+queue*(screenWidth-30)/2, 10+20*line, (screenWidth-30)/2, 14)];
            
            lb.font = [UIFont systemFontOfSize:textfont12];
            lb.textColor = [Utils colorRGB:@"#999999"];
            lb.text = self.resultViewLeftTitles[i];
            [_resultView addSubview:lb];
            [self.resultArr addObject:lb];
        }
    }
    return _resultView;
}

#pragma mark - Method

- (void)btnClicked:(UIButton *)button{
    if (button.tag == 101) {//up按钮动画
        //选中出现筛选框按钮（按钮太小所以给试图也加了一个点击操作）
        _TopCallBack(button);
    }else{
        self.currentButton = button;
        for (UIButton *btn in self.titlesButton) {
            btn.selected = NO;
        }
        button.selected = YES;
        _callback(button.tag);
    }
}

- (void)tapSiftAction:(UITapGestureRecognizer *)tap{
    _TopCallBack(tap);
}

@end
